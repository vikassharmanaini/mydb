import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:dartssh2/dartssh2.dart';
import 'package:mydb/models/ssh_config.dart';

/// Local TCP listener that forwards each connection through SSH to [remoteHost]:[remotePort].
final class SSHTunnelSession {
  SSHTunnelSession._(
    this._server,
    this._client,
    this._subscription,
  );

  final ServerSocket _server;
  final SSHClient _client;
  final StreamSubscription<Socket> _subscription;

  int get localPort => _server.port;

  /// Opens SSH to [ssh.host]:[ssh.port], then listens on loopback (ephemeral port).
  static Future<SSHTunnelSession> open({
    required SSHConfig ssh,
    required String remoteHost,
    required int remotePort,
    bool disableHostkeyVerification = true,
  }) async {
    if (ssh.privateKeyPath == null &&
        (ssh.password == null || ssh.password!.isEmpty)) {
      throw StateError(
        'SSH tunnel needs a private key path or SSH password.',
      );
    }

    final SSHSocket socket =
        await SSHSocket.connect(ssh.host, ssh.port, timeout: const Duration(seconds: 20));

    List<SSHKeyPair>? identities;
    final String? keyPath = ssh.privateKeyPath;
    if (keyPath != null && keyPath.isNotEmpty) {
      final String pem = await File(keyPath).readAsString();
      identities = SSHKeyPair.fromPem(pem);
    }

    final SSHClient client = SSHClient(
      socket,
      username: ssh.username,
      identities: identities,
      onPasswordRequest: ssh.password != null && ssh.password!.isNotEmpty
          ? () => ssh.password
          : null,
      disableHostkeyVerification: disableHostkeyVerification,
    );

    await client.authenticated;

    final ServerSocket server =
        await ServerSocket.bind(InternetAddress.loopbackIPv4, 0);
    // Subscription is cancelled in [close].
    // ignore: cancel_subscriptions
    final StreamSubscription<Socket> sub = server.listen(
      (Socket local) {
        unawaited(_relay(local, client, remoteHost, remotePort));
      },
    );

    return SSHTunnelSession._(server, client, sub);
  }

  static Future<void> _relay(
    Socket local,
    SSHClient client,
    String remoteHost,
    int remotePort,
  ) async {
    late final SSHForwardChannel forward;
    try {
      forward = await client.forwardLocal(remoteHost, remotePort);
    } catch (_) {
      await local.close();
      return;
    }

    final StreamSubscription<Uint8List> subIn = forward.stream.listen(
      local.add,
      onError: (Object _) {
        local.destroy();
        forward.close();
      },
      onDone: () => local.close(),
      cancelOnError: true,
    );

    final StreamSubscription<Uint8List> subOut = local.listen(
      forward.sink.add,
      onError: (Object _) => forward.close(),
      onDone: () => forward.close(),
      cancelOnError: true,
    );

    await forward.done;
    await subIn.cancel();
    await subOut.cancel();
  }

  Future<void> close() async {
    await _subscription.cancel();
    await _server.close();
    _client.close();
    await _client.done;
  }
}
