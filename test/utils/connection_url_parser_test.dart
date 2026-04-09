import 'package:flutter_test/flutter_test.dart';
import 'package:mydb/models/database_type.dart';
import 'package:mydb/models/ssl_config.dart';
import 'package:mydb/utils/connection_url_parser.dart';

void main() {
  const String id = 'id-1';
  final DateTime created = DateTime.utc(2026, 1, 1);

  test('postgres URL with user, password, port, database', () {
    final p = connectionProfileFromUrl(
      'postgres://alice:secret@db.example.com:5433/appdb',
      id: id,
      createdAt: created,
    );
    expect(p.type, DatabaseType.postgres);
    expect(p.host, 'db.example.com');
    expect(p.port, 5433);
    expect(p.database, 'appdb');
    expect(p.username, 'alice');
    expect(p.password, 'secret');
    expect(p.ssl?.mode, SslMode.require);
  });

  test('postgresql jdbc prefix', () {
    final p = connectionProfileFromUrl(
      'jdbc:postgresql://localhost/mydb',
      id: id,
      createdAt: created,
    );
    expect(p.type, DatabaseType.postgres);
    expect(p.host, 'localhost');
    expect(p.database, 'mydb');
    expect(p.username, 'postgres');
  });

  test('mysql URL default port and sslmode', () {
    final p = connectionProfileFromUrl(
      'mysql://user:pw@10.0.0.5/sales?sslmode=disable',
      id: id,
      createdAt: created,
    );
    expect(p.type, DatabaseType.mysql);
    expect(p.port, 3306);
    expect(p.ssl?.mode, SslMode.disable);
    expect(p.database, 'sales');
  });

  test('percent-encoded password', () {
    final p = connectionProfileFromUrl(
      'postgres://u:p%40ss%3Aword@h/db',
      id: id,
      createdAt: created,
    );
    expect(p.password, 'p@ss:word');
  });

  test('sqlite absolute path', () {
    final p = connectionProfileFromUrl(
      'sqlite:///tmp/test.sqlite',
      id: id,
      createdAt: created,
    );
    expect(p.type, DatabaseType.sqlite);
    expect(p.database, '/tmp/test.sqlite');
    expect(p.host, 'local');
  });

  test('sqlite :memory:', () {
    final p = connectionProfileFromUrl(
      'sqlite:///:memory:',
      id: id,
      createdAt: created,
    );
    expect(p.database, ':memory:');
    expect(p.host, ':memory:');
  });

  test('displayName override', () {
    final p = connectionProfileFromUrl(
      'postgres://localhost/x',
      id: id,
      createdAt: created,
      displayName: 'Staging',
    );
    expect(p.name, 'Staging');
  });

  test('invalid scheme', () {
    expect(
      () => connectionProfileFromUrl('http://x', id: id, createdAt: created),
      throwsFormatException,
    );
  });
}
