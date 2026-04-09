import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mydb/models/connection_pool_config.dart';
import 'package:mydb/models/connection_profile.dart';
import 'package:mydb/models/database_type.dart';
import 'package:mydb/models/ssh_config.dart';
import 'package:mydb/models/ssl_config.dart';
import 'package:mydb/services/connection_test_service.dart';
import 'package:mydb/services/credential_service.dart';
import 'package:mydb/state/connection_providers.dart';
import 'package:mydb/utils/connection_url_parser.dart';
import 'package:uuid/uuid.dart';

const Uuid _uuid = Uuid();

/// Types users can connect with from the UI (MSSQL remains a stub driver).
const List<DatabaseType> kConnectableDatabaseTypes = <DatabaseType>[
  DatabaseType.postgres,
  DatabaseType.mysql,
  DatabaseType.sqlite,
];

Future<void> showAddConnectionDialog(BuildContext context, WidgetRef ref) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext ctx) => _ConnectionFormDialog(ref: ref),
  );
}

Future<void> showConnectDialog(
  BuildContext context,
  WidgetRef ref,
  ConnectionProfile profile,
) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext ctx) => _QuickConnectDialog(
      ref: ref,
      profile: profile,
    ),
  );
}

Future<void> showConnectFromUrlDialog(BuildContext context, WidgetRef ref) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext ctx) => _UrlConnectDialog(ref: ref),
  );
}

class _QuickConnectDialog extends StatefulWidget {
  const _QuickConnectDialog({
    required this.ref,
    required this.profile,
  });

  final WidgetRef ref;
  final ConnectionProfile profile;

  @override
  State<_QuickConnectDialog> createState() => _QuickConnectDialogState();
}

class _QuickConnectDialogState extends State<_QuickConnectDialog> {
  final TextEditingController _password = TextEditingController();
  bool _busy = false;
  bool _rememberPassword = false;

  @override
  void initState() {
    super.initState();
    _prefillPassword();
  }

  Future<void> _prefillPassword() async {
    final CredentialService cred =
        await _ref.read(credentialServiceProvider.future);
    final String? saved = await cred.readPassword(_profile.id);
    if (!mounted || saved == null) {
      return;
    }
    setState(() => _password.text = saved);
  }

  bool get _needsPassword =>
      widget.profile.type == DatabaseType.postgres ||
      widget.profile.type == DatabaseType.mysql;

  WidgetRef get _ref => widget.ref;

  ConnectionProfile get _profile => widget.profile;

  @override
  void dispose() {
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Connect · ${_profile.name}'),
      content: SizedBox(
        width: 360,
        child: _needsPassword
            ? Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextField(
                    controller: _password,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    onSubmitted: (_) => _go(),
                  ),
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Remember password (OS keychain)'),
                    value: _rememberPassword,
                    onChanged: (bool? v) =>
                        setState(() => _rememberPassword = v ?? false),
                  ),
                ],
              )
            : Text(
                'Connect to ${_profile.type.displayName}?',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: _busy ? null : () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _busy ? null : _go,
          child: _busy
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Connect'),
        ),
      ],
    );
  }

  Future<void> _go() async {
    setState(() => _busy = true);
    final ConnectionProfile withSecret = _profile.copyWith(
      password: _needsPassword
          ? (_password.text.isEmpty ? null : _password.text)
          : null,
    );
    try {
      await _ref.read(liveConnectionsProvider.notifier).connect(withSecret);
      if (!mounted) {
        return;
      }
      if (_rememberPassword &&
          _needsPassword &&
          withSecret.password != null &&
          withSecret.password!.isNotEmpty) {
        final CredentialService cred =
            await _ref.read(credentialServiceProvider.future);
        await cred.storePassword(withSecret.id, withSecret.password!);
      }
      if (!mounted) {
        return;
      }
      _ref.read(selectedConnectionIdProvider.notifier).select(withSecret.id);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Connected to ${_profile.name}'),
        ),
      );
    } catch (e) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Connection failed: $e'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _busy = false);
      }
    }
  }
}

class _UrlConnectDialog extends StatefulWidget {
  const _UrlConnectDialog({required this.ref});

  final WidgetRef ref;

  @override
  State<_UrlConnectDialog> createState() => _UrlConnectDialogState();
}

class _UrlConnectDialogState extends State<_UrlConnectDialog> {
  WidgetRef get _ref => widget.ref;
  final TextEditingController _url = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _saveConnection = true;
  bool _rememberPassword = true;
  bool _busy = false;
  String? _parseError;

  @override
  void dispose() {
    _url.dispose();
    _name.dispose();
    super.dispose();
  }

  ConnectionProfile? _tryParseProfile() {
    setState(() => _parseError = null);
    try {
      return connectionProfileFromUrl(
        _url.text,
        id: _uuid.v4(),
        createdAt: DateTime.now().toUtc(),
        displayName: _name.text.trim().isEmpty ? null : _name.text.trim(),
      );
    } on FormatException catch (e) {
      setState(() => _parseError = e.message);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Connect from URL'),
      content: SizedBox(
        width: 440,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  controller: _url,
                  decoration: const InputDecoration(
                    labelText: 'Connection URL',
                    hintText:
                        'postgres://user@localhost:5432/mydb?sslmode=disable',
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                  maxLines: 3,
                  keyboardType: TextInputType.url,
                  validator: (String? v) {
                    if (v == null || v.trim().isEmpty) {
                      return 'Paste a connection URL';
                    }
                    try {
                      connectionProfileFromUrl(
                        v,
                        id: 'validate',
                        createdAt: DateTime.now().toUtc(),
                      );
                    } on FormatException catch (e) {
                      return e.message;
                    }
                    return null;
                  },
                  onChanged: (_) {
                    if (_parseError != null) {
                      setState(() => _parseError = null);
                    }
                  },
                ),
                if (_parseError != null) ...<Widget>[
                  const SizedBox(height: 8),
                  Text(
                    _parseError!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                      fontSize: 12,
                    ),
                  ),
                ],
                const SizedBox(height: 12),
                TextFormField(
                  controller: _name,
                  decoration: const InputDecoration(
                    labelText: 'Display name (optional)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Save connection'),
                  value: _saveConnection,
                  onChanged: (bool? v) =>
                      setState(() => _saveConnection = v ?? true),
                ),
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Remember password (OS keychain)'),
                  subtitle: const Text(
                    'Only if the URL includes a password',
                    style: TextStyle(fontSize: 12),
                  ),
                  value: _rememberPassword,
                  onChanged: (bool? v) =>
                      setState(() => _rememberPassword = v ?? true),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: _busy ? null : () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _busy ? null : _connect,
          child: _busy
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Connect'),
        ),
      ],
    );
  }

  Future<void> _connect() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() => _busy = true);
    final ConnectionProfile? parsed = _tryParseProfile();
    if (parsed == null) {
      if (mounted) {
        setState(() => _busy = false);
      }
      return;
    }
    final ConnectionProfile profile = parsed;
    try {
      if (_saveConnection) {
        await _ref.read(savedConnectionProfilesProvider.notifier).upsert(profile);
      }
      await _ref.read(liveConnectionsProvider.notifier).connect(profile);
      if (!mounted) {
        return;
      }
      final bool hasPassword =
          profile.password != null && profile.password!.isNotEmpty;
      if (_rememberPassword &&
          _saveConnection &&
          hasPassword &&
          profile.type != DatabaseType.sqlite) {
        final CredentialService cred =
            await _ref.read(credentialServiceProvider.future);
        await cred.storePassword(profile.id, profile.password!);
      }
      if (!mounted) {
        return;
      }
      _ref.read(selectedConnectionIdProvider.notifier).select(profile.id);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Connected to ${profile.name}')),
      );
    } catch (e) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Connection failed: $e'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _busy = false);
      }
    }
  }
}

class _ConnectionFormDialog extends StatefulWidget {
  const _ConnectionFormDialog({required this.ref});

  final WidgetRef ref;

  @override
  State<_ConnectionFormDialog> createState() => _ConnectionFormDialogState();
}

class _ConnectionFormDialogState extends State<_ConnectionFormDialog> {
  WidgetRef get _ref => widget.ref;
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _host = TextEditingController(text: '127.0.0.1');
  final _port = TextEditingController(text: '5432');
  final _database = TextEditingController();
  final _user = TextEditingController();
  final _password = TextEditingController();
  final _sslCa = TextEditingController();
  final _sshHost = TextEditingController();
  final _sshPort = TextEditingController(text: '22');
  final _sshUser = TextEditingController();
  final _sshPass = TextEditingController();
  final _sshKey = TextEditingController();
  final _poolMin = TextEditingController(text: '1');
  final _poolMax = TextEditingController(text: '10');
  DatabaseType _type = DatabaseType.postgres;
  SslMode _sslMode = SslMode.require;
  bool _sshEnabled = false;
  bool _rememberPassword = false;
  bool _busy = false;

  @override
  void dispose() {
    _name.dispose();
    _host.dispose();
    _port.dispose();
    _database.dispose();
    _user.dispose();
    _password.dispose();
    _sslCa.dispose();
    _sshHost.dispose();
    _sshPort.dispose();
    _sshUser.dispose();
    _sshPass.dispose();
    _sshKey.dispose();
    _poolMin.dispose();
    _poolMax.dispose();
    super.dispose();
  }

  void _syncDefaultsForType() {
    _port.text = '${_type.defaultPort}';
    if (_type == DatabaseType.sqlite) {
      _host.text = '';
      _user.text = '';
    } else if (_host.text.isEmpty) {
      _host.text = '127.0.0.1';
    }
  }

  bool get _isSqlite => _type == DatabaseType.sqlite;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New connection'),
      content: SizedBox(
        width: 420,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  controller: _name,
                  decoration: const InputDecoration(
                    labelText: 'Display name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (String? v) =>
                      v == null || v.trim().isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 12),
                InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Database type',
                    border: OutlineInputBorder(),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<DatabaseType>(
                      value: _type,
                      isExpanded: true,
                      items: kConnectableDatabaseTypes
                          .map(
                            (DatabaseType t) =>
                                DropdownMenuItem<DatabaseType>(
                              value: t,
                              child: Text(t.displayName),
                            ),
                          )
                          .toList(),
                      onChanged: (DatabaseType? v) {
                        if (v != null) {
                          setState(() {
                            _type = v;
                            _syncDefaultsForType();
                          });
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                if (!_isSqlite) ...<Widget>[
                  TextFormField(
                    controller: _host,
                    decoration: const InputDecoration(
                      labelText: 'Host',
                      border: OutlineInputBorder(),
                    ),
                    validator: (String? v) =>
                        v == null || v.trim().isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _port,
                    decoration: const InputDecoration(
                      labelText: 'Port',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (String? v) {
                      final int? p = int.tryParse(v ?? '');
                      if (p == null || p <= 0) {
                        return 'Invalid port';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                ],
                TextFormField(
                  controller: _database,
                  decoration: InputDecoration(
                    labelText:
                        _isSqlite ? 'Database file path' : 'Database name',
                    border: const OutlineInputBorder(),
                    suffixIcon: _isSqlite
                        ? IconButton(
                            tooltip: 'Browse',
                            icon: const Icon(Icons.folder_open),
                            onPressed: () async {
                              final FilePickerResult? r =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.any,
                                dialogTitle: 'SQLite database file',
                              );
                              final String? path = r?.files.single.path;
                              if (path != null) {
                                setState(() => _database.text = path);
                              }
                            },
                          )
                        : null,
                  ),
                  validator: (String? v) =>
                      v == null || v.trim().isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 12),
                if (!_isSqlite) ...<Widget>[
                  TextFormField(
                    controller: _user,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                    ),
                    validator: (String? v) =>
                        v == null || v.trim().isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _password,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<SslMode>(
                    decoration: const InputDecoration(
                      labelText: 'SSL mode',
                      border: OutlineInputBorder(),
                    ),
                    value: _sslMode,
                    items: SslMode.values
                        .map(
                          (SslMode m) => DropdownMenuItem<SslMode>(
                            value: m,
                            child: Text(m.name),
                          ),
                        )
                        .toList(),
                    onChanged: (SslMode? v) {
                      if (v != null) {
                        setState(() => _sslMode = v);
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _sslCa,
                    decoration: const InputDecoration(
                      labelText: 'CA certificate path (optional)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('SSH tunnel to database host'),
                    value: _sshEnabled,
                    onChanged: (bool? v) =>
                        setState(() => _sshEnabled = v ?? false),
                  ),
                  if (_sshEnabled) ...<Widget>[
                    TextFormField(
                      controller: _sshHost,
                      decoration: const InputDecoration(
                        labelText: 'SSH host',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _sshPort,
                      decoration: const InputDecoration(
                        labelText: 'SSH port',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _sshUser,
                      decoration: const InputDecoration(
                        labelText: 'SSH username',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _sshPass,
                      decoration: const InputDecoration(
                        labelText: 'SSH password (optional if using key)',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _sshKey,
                      decoration: InputDecoration(
                        labelText: 'SSH private key path',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.folder_open),
                          onPressed: () async {
                            final FilePickerResult? r =
                                await FilePicker.platform.pickFiles(
                              type: FileType.any,
                            );
                            final String? path = r?.files.single.path;
                            if (path != null) {
                              setState(() => _sshKey.text = path);
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _poolMin,
                    decoration: const InputDecoration(
                      labelText: 'Pool min connections (Postgres roadmap)',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _poolMax,
                    decoration: const InputDecoration(
                      labelText: 'Pool max connections',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Remember password (OS keychain)'),
                    value: _rememberPassword,
                    onChanged: (bool? v) =>
                        setState(() => _rememberPassword = v ?? false),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: _busy ? null : () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: _busy ? null : _testOnly,
          child: const Text('Test'),
        ),
        TextButton(
          onPressed: _busy ? null : _saveOnly,
          child: const Text('Save'),
        ),
        FilledButton(
          onPressed: _busy ? null : _saveAndConnect,
          child: _busy
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Save & connect'),
        ),
      ],
    );
  }

  SSLConfig? _sslForType() {
    if (_isSqlite) {
      return null;
    }
    return SSLConfig(
      mode: _sslMode,
      caCertPath:
          _sslCa.text.trim().isEmpty ? null : _sslCa.text.trim(),
    );
  }

  SSHConfig? _sshConfig() {
    if (_isSqlite || !_sshEnabled) {
      return null;
    }
    if (_sshHost.text.trim().isEmpty || _sshUser.text.trim().isEmpty) {
      return null;
    }
    return SSHConfig(
      host: _sshHost.text.trim(),
      port: int.tryParse(_sshPort.text.trim()) ?? 22,
      username: _sshUser.text.trim(),
      privateKeyPath:
          _sshKey.text.trim().isEmpty ? null : _sshKey.text.trim(),
      password: _sshPass.text.isEmpty ? null : _sshPass.text,
    );
  }

  ConnectionProfile _buildProfile() {
    final int port = _isSqlite ? 0 : int.parse(_port.text.trim());
    return ConnectionProfile(
      id: _uuid.v4(),
      name: _name.text.trim(),
      type: _type,
      host: _isSqlite ? 'local' : _host.text.trim(),
      port: port,
      database: _database.text.trim(),
      username: _isSqlite ? '' : _user.text.trim(),
      password: _isSqlite
          ? null
          : (_password.text.isEmpty ? null : _password.text),
      ssl: _sslForType(),
      ssh: _sshConfig(),
      pool: ConnectionPoolConfig(
        minSize: int.tryParse(_poolMin.text.trim()) ?? 1,
        maxSize: int.tryParse(_poolMax.text.trim()) ?? 10,
      ),
      createdAt: DateTime.now().toUtc(),
    );
  }

  Future<void> _testOnly() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() => _busy = true);
    try {
      await testConnectionProfile(_buildProfile());
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Connection succeeded.')),
      );
    } catch (e) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Connection test failed: $e'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _busy = false);
      }
    }
  }

  Future<void> _saveOnly() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final ConnectionProfile p = _buildProfile();
    await _ref.read(savedConnectionProfilesProvider.notifier).upsert(p);
    if (!mounted) {
      return;
    }
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Saved "${p.name}"')),
    );
  }

  Future<void> _saveAndConnect() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() => _busy = true);
    final ConnectionProfile p = _buildProfile();
    await _ref.read(savedConnectionProfilesProvider.notifier).upsert(p);
    try {
      await _ref.read(liveConnectionsProvider.notifier).connect(p);
      if (!mounted) {
        return;
      }
      if (_rememberPassword &&
          !_isSqlite &&
          p.password != null &&
          p.password!.isNotEmpty) {
        final CredentialService cred =
            await _ref.read(credentialServiceProvider.future);
        await cred.storePassword(p.id, p.password!);
      }
      if (!mounted) {
        return;
      }
      _ref.read(selectedConnectionIdProvider.notifier).select(p.id);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Connected to ${p.name}')),
      );
    } catch (e) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Connection failed: $e'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _busy = false);
      }
    }
  }
}
