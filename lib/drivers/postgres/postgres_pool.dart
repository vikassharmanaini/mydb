import 'dart:async';

import 'package:postgres/postgres.dart' as pg;

/// Optional multi-connection pool for PostgreSQL (roadmap T-217).
///
/// Not yet wired into [PostgresDriver]; single [pg.Connection] remains the
/// default until checkout/transaction rules are defined.
final class PostgresConnectionPool {
  PostgresConnectionPool({
    required this.minSize,
    required this.maxSize,
  })  : assert(minSize >= 0),
        assert(maxSize >= minSize);

  final int minSize;
  final int maxSize;

  final List<pg.Connection> _connections = <pg.Connection>[];

  int get activeCount => _connections.length;

  /// Placeholder for future acquire/release of pooled connections.
  Future<pg.Connection> checkout(
    pg.Endpoint endpoint,
    pg.ConnectionSettings settings,
  ) async {
    if (_connections.isEmpty) {
      return pg.Connection.open(endpoint, settings: settings);
    }
    return _connections.removeLast();
  }

  void release(pg.Connection c) {
    if (_connections.length < maxSize) {
      _connections.add(c);
    } else {
      unawaited(c.close());
    }
  }

  Future<void> dispose() async {
    for (final pg.Connection c in _connections) {
      await c.close();
    }
    _connections.clear();
  }
}
