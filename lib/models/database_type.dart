import 'package:json_annotation/json_annotation.dart';

/// Supported database engines (driver registry keys).
enum DatabaseType {
  @JsonValue('postgres')
  postgres,
  @JsonValue('mysql')
  mysql,
  @JsonValue('sqlite')
  sqlite,
  @JsonValue('mssql')
  mssql,
}

extension DatabaseTypeX on DatabaseType {
  String get displayName => switch (this) {
        DatabaseType.postgres => 'PostgreSQL',
        DatabaseType.mysql => 'MySQL / MariaDB',
        DatabaseType.sqlite => 'SQLite',
        DatabaseType.mssql => 'Microsoft SQL Server',
      };

  /// Default TCP port when not using SSH or custom config.
  int get defaultPort => switch (this) {
        DatabaseType.postgres => 5432,
        DatabaseType.mysql => 3306,
        DatabaseType.sqlite => 0,
        DatabaseType.mssql => 1433,
      };
}
