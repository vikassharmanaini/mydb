// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $QueryHistoryTable extends QueryHistory
    with TableInfo<$QueryHistoryTable, QueryHistoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QueryHistoryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _connectionIdMeta =
      const VerificationMeta('connectionId');
  @override
  late final GeneratedColumn<String> connectionId = GeneratedColumn<String>(
      'connection_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _databaseTypeMeta =
      const VerificationMeta('databaseType');
  @override
  late final GeneratedColumn<String> databaseType = GeneratedColumn<String>(
      'database_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sqlMeta = const VerificationMeta('sql');
  @override
  late final GeneratedColumn<String> sql = GeneratedColumn<String>(
      'sql', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _executedAtMeta =
      const VerificationMeta('executedAt');
  @override
  late final GeneratedColumn<DateTime> executedAt = GeneratedColumn<DateTime>(
      'executed_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _durationMsMeta =
      const VerificationMeta('durationMs');
  @override
  late final GeneratedColumn<int> durationMs = GeneratedColumn<int>(
      'duration_ms', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _successMeta =
      const VerificationMeta('success');
  @override
  late final GeneratedColumn<bool> success = GeneratedColumn<bool>(
      'success', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("success" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, connectionId, databaseType, sql, executedAt, durationMs, success];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'query_history';
  @override
  VerificationContext validateIntegrity(Insertable<QueryHistoryData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('connection_id')) {
      context.handle(
          _connectionIdMeta,
          connectionId.isAcceptableOrUnknown(
              data['connection_id']!, _connectionIdMeta));
    } else if (isInserting) {
      context.missing(_connectionIdMeta);
    }
    if (data.containsKey('database_type')) {
      context.handle(
          _databaseTypeMeta,
          databaseType.isAcceptableOrUnknown(
              data['database_type']!, _databaseTypeMeta));
    } else if (isInserting) {
      context.missing(_databaseTypeMeta);
    }
    if (data.containsKey('sql')) {
      context.handle(
          _sqlMeta, sql.isAcceptableOrUnknown(data['sql']!, _sqlMeta));
    } else if (isInserting) {
      context.missing(_sqlMeta);
    }
    if (data.containsKey('executed_at')) {
      context.handle(
          _executedAtMeta,
          executedAt.isAcceptableOrUnknown(
              data['executed_at']!, _executedAtMeta));
    } else if (isInserting) {
      context.missing(_executedAtMeta);
    }
    if (data.containsKey('duration_ms')) {
      context.handle(
          _durationMsMeta,
          durationMs.isAcceptableOrUnknown(
              data['duration_ms']!, _durationMsMeta));
    }
    if (data.containsKey('success')) {
      context.handle(_successMeta,
          success.isAcceptableOrUnknown(data['success']!, _successMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QueryHistoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QueryHistoryData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      connectionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}connection_id'])!,
      databaseType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}database_type'])!,
      sql: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sql'])!,
      executedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}executed_at'])!,
      durationMs: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_ms']),
      success: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}success'])!,
    );
  }

  @override
  $QueryHistoryTable createAlias(String alias) {
    return $QueryHistoryTable(attachedDatabase, alias);
  }
}

class QueryHistoryData extends DataClass
    implements Insertable<QueryHistoryData> {
  final String id;
  final String connectionId;
  final String databaseType;
  final String sql;
  final DateTime executedAt;
  final int? durationMs;
  final bool success;
  const QueryHistoryData(
      {required this.id,
      required this.connectionId,
      required this.databaseType,
      required this.sql,
      required this.executedAt,
      this.durationMs,
      required this.success});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['connection_id'] = Variable<String>(connectionId);
    map['database_type'] = Variable<String>(databaseType);
    map['sql'] = Variable<String>(sql);
    map['executed_at'] = Variable<DateTime>(executedAt);
    if (!nullToAbsent || durationMs != null) {
      map['duration_ms'] = Variable<int>(durationMs);
    }
    map['success'] = Variable<bool>(success);
    return map;
  }

  QueryHistoryCompanion toCompanion(bool nullToAbsent) {
    return QueryHistoryCompanion(
      id: Value(id),
      connectionId: Value(connectionId),
      databaseType: Value(databaseType),
      sql: Value(sql),
      executedAt: Value(executedAt),
      durationMs: durationMs == null && nullToAbsent
          ? const Value.absent()
          : Value(durationMs),
      success: Value(success),
    );
  }

  factory QueryHistoryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QueryHistoryData(
      id: serializer.fromJson<String>(json['id']),
      connectionId: serializer.fromJson<String>(json['connectionId']),
      databaseType: serializer.fromJson<String>(json['databaseType']),
      sql: serializer.fromJson<String>(json['sql']),
      executedAt: serializer.fromJson<DateTime>(json['executedAt']),
      durationMs: serializer.fromJson<int?>(json['durationMs']),
      success: serializer.fromJson<bool>(json['success']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'connectionId': serializer.toJson<String>(connectionId),
      'databaseType': serializer.toJson<String>(databaseType),
      'sql': serializer.toJson<String>(sql),
      'executedAt': serializer.toJson<DateTime>(executedAt),
      'durationMs': serializer.toJson<int?>(durationMs),
      'success': serializer.toJson<bool>(success),
    };
  }

  QueryHistoryData copyWith(
          {String? id,
          String? connectionId,
          String? databaseType,
          String? sql,
          DateTime? executedAt,
          Value<int?> durationMs = const Value.absent(),
          bool? success}) =>
      QueryHistoryData(
        id: id ?? this.id,
        connectionId: connectionId ?? this.connectionId,
        databaseType: databaseType ?? this.databaseType,
        sql: sql ?? this.sql,
        executedAt: executedAt ?? this.executedAt,
        durationMs: durationMs.present ? durationMs.value : this.durationMs,
        success: success ?? this.success,
      );
  QueryHistoryData copyWithCompanion(QueryHistoryCompanion data) {
    return QueryHistoryData(
      id: data.id.present ? data.id.value : this.id,
      connectionId: data.connectionId.present
          ? data.connectionId.value
          : this.connectionId,
      databaseType: data.databaseType.present
          ? data.databaseType.value
          : this.databaseType,
      sql: data.sql.present ? data.sql.value : this.sql,
      executedAt:
          data.executedAt.present ? data.executedAt.value : this.executedAt,
      durationMs:
          data.durationMs.present ? data.durationMs.value : this.durationMs,
      success: data.success.present ? data.success.value : this.success,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QueryHistoryData(')
          ..write('id: $id, ')
          ..write('connectionId: $connectionId, ')
          ..write('databaseType: $databaseType, ')
          ..write('sql: $sql, ')
          ..write('executedAt: $executedAt, ')
          ..write('durationMs: $durationMs, ')
          ..write('success: $success')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, connectionId, databaseType, sql, executedAt, durationMs, success);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QueryHistoryData &&
          other.id == this.id &&
          other.connectionId == this.connectionId &&
          other.databaseType == this.databaseType &&
          other.sql == this.sql &&
          other.executedAt == this.executedAt &&
          other.durationMs == this.durationMs &&
          other.success == this.success);
}

class QueryHistoryCompanion extends UpdateCompanion<QueryHistoryData> {
  final Value<String> id;
  final Value<String> connectionId;
  final Value<String> databaseType;
  final Value<String> sql;
  final Value<DateTime> executedAt;
  final Value<int?> durationMs;
  final Value<bool> success;
  final Value<int> rowid;
  const QueryHistoryCompanion({
    this.id = const Value.absent(),
    this.connectionId = const Value.absent(),
    this.databaseType = const Value.absent(),
    this.sql = const Value.absent(),
    this.executedAt = const Value.absent(),
    this.durationMs = const Value.absent(),
    this.success = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QueryHistoryCompanion.insert({
    required String id,
    required String connectionId,
    required String databaseType,
    required String sql,
    required DateTime executedAt,
    this.durationMs = const Value.absent(),
    this.success = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        connectionId = Value(connectionId),
        databaseType = Value(databaseType),
        sql = Value(sql),
        executedAt = Value(executedAt);
  static Insertable<QueryHistoryData> custom({
    Expression<String>? id,
    Expression<String>? connectionId,
    Expression<String>? databaseType,
    Expression<String>? sql,
    Expression<DateTime>? executedAt,
    Expression<int>? durationMs,
    Expression<bool>? success,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (connectionId != null) 'connection_id': connectionId,
      if (databaseType != null) 'database_type': databaseType,
      if (sql != null) 'sql': sql,
      if (executedAt != null) 'executed_at': executedAt,
      if (durationMs != null) 'duration_ms': durationMs,
      if (success != null) 'success': success,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QueryHistoryCompanion copyWith(
      {Value<String>? id,
      Value<String>? connectionId,
      Value<String>? databaseType,
      Value<String>? sql,
      Value<DateTime>? executedAt,
      Value<int?>? durationMs,
      Value<bool>? success,
      Value<int>? rowid}) {
    return QueryHistoryCompanion(
      id: id ?? this.id,
      connectionId: connectionId ?? this.connectionId,
      databaseType: databaseType ?? this.databaseType,
      sql: sql ?? this.sql,
      executedAt: executedAt ?? this.executedAt,
      durationMs: durationMs ?? this.durationMs,
      success: success ?? this.success,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (connectionId.present) {
      map['connection_id'] = Variable<String>(connectionId.value);
    }
    if (databaseType.present) {
      map['database_type'] = Variable<String>(databaseType.value);
    }
    if (sql.present) {
      map['sql'] = Variable<String>(sql.value);
    }
    if (executedAt.present) {
      map['executed_at'] = Variable<DateTime>(executedAt.value);
    }
    if (durationMs.present) {
      map['duration_ms'] = Variable<int>(durationMs.value);
    }
    if (success.present) {
      map['success'] = Variable<bool>(success.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QueryHistoryCompanion(')
          ..write('id: $id, ')
          ..write('connectionId: $connectionId, ')
          ..write('databaseType: $databaseType, ')
          ..write('sql: $sql, ')
          ..write('executedAt: $executedAt, ')
          ..write('durationMs: $durationMs, ')
          ..write('success: $success, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SnippetsTable extends Snippets
    with TableInfo<$SnippetsTable, SnippetRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SnippetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sqlMeta = const VerificationMeta('sql');
  @override
  late final GeneratedColumn<String> sql = GeneratedColumn<String>(
      'sql', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tagsJsonMeta =
      const VerificationMeta('tagsJson');
  @override
  late final GeneratedColumn<String> tagsJson = GeneratedColumn<String>(
      'tags_json', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('[]'));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, title, sql, tagsJson, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'snippets';
  @override
  VerificationContext validateIntegrity(Insertable<SnippetRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('sql')) {
      context.handle(
          _sqlMeta, sql.isAcceptableOrUnknown(data['sql']!, _sqlMeta));
    } else if (isInserting) {
      context.missing(_sqlMeta);
    }
    if (data.containsKey('tags_json')) {
      context.handle(_tagsJsonMeta,
          tagsJson.isAcceptableOrUnknown(data['tags_json']!, _tagsJsonMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SnippetRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SnippetRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      sql: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sql'])!,
      tagsJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tags_json'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $SnippetsTable createAlias(String alias) {
    return $SnippetsTable(attachedDatabase, alias);
  }
}

class SnippetRow extends DataClass implements Insertable<SnippetRow> {
  final String id;
  final String title;
  final String sql;
  final String tagsJson;
  final DateTime updatedAt;
  const SnippetRow(
      {required this.id,
      required this.title,
      required this.sql,
      required this.tagsJson,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['sql'] = Variable<String>(sql);
    map['tags_json'] = Variable<String>(tagsJson);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SnippetsCompanion toCompanion(bool nullToAbsent) {
    return SnippetsCompanion(
      id: Value(id),
      title: Value(title),
      sql: Value(sql),
      tagsJson: Value(tagsJson),
      updatedAt: Value(updatedAt),
    );
  }

  factory SnippetRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SnippetRow(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      sql: serializer.fromJson<String>(json['sql']),
      tagsJson: serializer.fromJson<String>(json['tagsJson']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'sql': serializer.toJson<String>(sql),
      'tagsJson': serializer.toJson<String>(tagsJson),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SnippetRow copyWith(
          {String? id,
          String? title,
          String? sql,
          String? tagsJson,
          DateTime? updatedAt}) =>
      SnippetRow(
        id: id ?? this.id,
        title: title ?? this.title,
        sql: sql ?? this.sql,
        tagsJson: tagsJson ?? this.tagsJson,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  SnippetRow copyWithCompanion(SnippetsCompanion data) {
    return SnippetRow(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      sql: data.sql.present ? data.sql.value : this.sql,
      tagsJson: data.tagsJson.present ? data.tagsJson.value : this.tagsJson,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SnippetRow(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('sql: $sql, ')
          ..write('tagsJson: $tagsJson, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, sql, tagsJson, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SnippetRow &&
          other.id == this.id &&
          other.title == this.title &&
          other.sql == this.sql &&
          other.tagsJson == this.tagsJson &&
          other.updatedAt == this.updatedAt);
}

class SnippetsCompanion extends UpdateCompanion<SnippetRow> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> sql;
  final Value<String> tagsJson;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SnippetsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.sql = const Value.absent(),
    this.tagsJson = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SnippetsCompanion.insert({
    required String id,
    required String title,
    required String sql,
    this.tagsJson = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        sql = Value(sql),
        updatedAt = Value(updatedAt);
  static Insertable<SnippetRow> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? sql,
    Expression<String>? tagsJson,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (sql != null) 'sql': sql,
      if (tagsJson != null) 'tags_json': tagsJson,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SnippetsCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String>? sql,
      Value<String>? tagsJson,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return SnippetsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      sql: sql ?? this.sql,
      tagsJson: tagsJson ?? this.tagsJson,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (sql.present) {
      map['sql'] = Variable<String>(sql.value);
    }
    if (tagsJson.present) {
      map['tags_json'] = Variable<String>(tagsJson.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SnippetsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('sql: $sql, ')
          ..write('tagsJson: $tagsJson, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $QueryHistoryTable queryHistory = $QueryHistoryTable(this);
  late final $SnippetsTable snippets = $SnippetsTable(this);
  late final HistoryDao historyDao = HistoryDao(this as AppDatabase);
  late final SnippetDao snippetDao = SnippetDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [queryHistory, snippets];
}

typedef $$QueryHistoryTableCreateCompanionBuilder = QueryHistoryCompanion
    Function({
  required String id,
  required String connectionId,
  required String databaseType,
  required String sql,
  required DateTime executedAt,
  Value<int?> durationMs,
  Value<bool> success,
  Value<int> rowid,
});
typedef $$QueryHistoryTableUpdateCompanionBuilder = QueryHistoryCompanion
    Function({
  Value<String> id,
  Value<String> connectionId,
  Value<String> databaseType,
  Value<String> sql,
  Value<DateTime> executedAt,
  Value<int?> durationMs,
  Value<bool> success,
  Value<int> rowid,
});

class $$QueryHistoryTableFilterComposer
    extends Composer<_$AppDatabase, $QueryHistoryTable> {
  $$QueryHistoryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get connectionId => $composableBuilder(
      column: $table.connectionId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get databaseType => $composableBuilder(
      column: $table.databaseType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sql => $composableBuilder(
      column: $table.sql, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get executedAt => $composableBuilder(
      column: $table.executedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durationMs => $composableBuilder(
      column: $table.durationMs, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get success => $composableBuilder(
      column: $table.success, builder: (column) => ColumnFilters(column));
}

class $$QueryHistoryTableOrderingComposer
    extends Composer<_$AppDatabase, $QueryHistoryTable> {
  $$QueryHistoryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get connectionId => $composableBuilder(
      column: $table.connectionId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get databaseType => $composableBuilder(
      column: $table.databaseType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sql => $composableBuilder(
      column: $table.sql, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get executedAt => $composableBuilder(
      column: $table.executedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationMs => $composableBuilder(
      column: $table.durationMs, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get success => $composableBuilder(
      column: $table.success, builder: (column) => ColumnOrderings(column));
}

class $$QueryHistoryTableAnnotationComposer
    extends Composer<_$AppDatabase, $QueryHistoryTable> {
  $$QueryHistoryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get connectionId => $composableBuilder(
      column: $table.connectionId, builder: (column) => column);

  GeneratedColumn<String> get databaseType => $composableBuilder(
      column: $table.databaseType, builder: (column) => column);

  GeneratedColumn<String> get sql =>
      $composableBuilder(column: $table.sql, builder: (column) => column);

  GeneratedColumn<DateTime> get executedAt => $composableBuilder(
      column: $table.executedAt, builder: (column) => column);

  GeneratedColumn<int> get durationMs => $composableBuilder(
      column: $table.durationMs, builder: (column) => column);

  GeneratedColumn<bool> get success =>
      $composableBuilder(column: $table.success, builder: (column) => column);
}

class $$QueryHistoryTableTableManager extends RootTableManager<
    _$AppDatabase,
    $QueryHistoryTable,
    QueryHistoryData,
    $$QueryHistoryTableFilterComposer,
    $$QueryHistoryTableOrderingComposer,
    $$QueryHistoryTableAnnotationComposer,
    $$QueryHistoryTableCreateCompanionBuilder,
    $$QueryHistoryTableUpdateCompanionBuilder,
    (
      QueryHistoryData,
      BaseReferences<_$AppDatabase, $QueryHistoryTable, QueryHistoryData>
    ),
    QueryHistoryData,
    PrefetchHooks Function()> {
  $$QueryHistoryTableTableManager(_$AppDatabase db, $QueryHistoryTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QueryHistoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QueryHistoryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QueryHistoryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> connectionId = const Value.absent(),
            Value<String> databaseType = const Value.absent(),
            Value<String> sql = const Value.absent(),
            Value<DateTime> executedAt = const Value.absent(),
            Value<int?> durationMs = const Value.absent(),
            Value<bool> success = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              QueryHistoryCompanion(
            id: id,
            connectionId: connectionId,
            databaseType: databaseType,
            sql: sql,
            executedAt: executedAt,
            durationMs: durationMs,
            success: success,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String connectionId,
            required String databaseType,
            required String sql,
            required DateTime executedAt,
            Value<int?> durationMs = const Value.absent(),
            Value<bool> success = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              QueryHistoryCompanion.insert(
            id: id,
            connectionId: connectionId,
            databaseType: databaseType,
            sql: sql,
            executedAt: executedAt,
            durationMs: durationMs,
            success: success,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$QueryHistoryTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $QueryHistoryTable,
    QueryHistoryData,
    $$QueryHistoryTableFilterComposer,
    $$QueryHistoryTableOrderingComposer,
    $$QueryHistoryTableAnnotationComposer,
    $$QueryHistoryTableCreateCompanionBuilder,
    $$QueryHistoryTableUpdateCompanionBuilder,
    (
      QueryHistoryData,
      BaseReferences<_$AppDatabase, $QueryHistoryTable, QueryHistoryData>
    ),
    QueryHistoryData,
    PrefetchHooks Function()>;
typedef $$SnippetsTableCreateCompanionBuilder = SnippetsCompanion Function({
  required String id,
  required String title,
  required String sql,
  Value<String> tagsJson,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$SnippetsTableUpdateCompanionBuilder = SnippetsCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<String> sql,
  Value<String> tagsJson,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$SnippetsTableFilterComposer
    extends Composer<_$AppDatabase, $SnippetsTable> {
  $$SnippetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sql => $composableBuilder(
      column: $table.sql, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tagsJson => $composableBuilder(
      column: $table.tagsJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$SnippetsTableOrderingComposer
    extends Composer<_$AppDatabase, $SnippetsTable> {
  $$SnippetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sql => $composableBuilder(
      column: $table.sql, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tagsJson => $composableBuilder(
      column: $table.tagsJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$SnippetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SnippetsTable> {
  $$SnippetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get sql =>
      $composableBuilder(column: $table.sql, builder: (column) => column);

  GeneratedColumn<String> get tagsJson =>
      $composableBuilder(column: $table.tagsJson, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SnippetsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SnippetsTable,
    SnippetRow,
    $$SnippetsTableFilterComposer,
    $$SnippetsTableOrderingComposer,
    $$SnippetsTableAnnotationComposer,
    $$SnippetsTableCreateCompanionBuilder,
    $$SnippetsTableUpdateCompanionBuilder,
    (SnippetRow, BaseReferences<_$AppDatabase, $SnippetsTable, SnippetRow>),
    SnippetRow,
    PrefetchHooks Function()> {
  $$SnippetsTableTableManager(_$AppDatabase db, $SnippetsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SnippetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SnippetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SnippetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> sql = const Value.absent(),
            Value<String> tagsJson = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SnippetsCompanion(
            id: id,
            title: title,
            sql: sql,
            tagsJson: tagsJson,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            required String sql,
            Value<String> tagsJson = const Value.absent(),
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              SnippetsCompanion.insert(
            id: id,
            title: title,
            sql: sql,
            tagsJson: tagsJson,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SnippetsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SnippetsTable,
    SnippetRow,
    $$SnippetsTableFilterComposer,
    $$SnippetsTableOrderingComposer,
    $$SnippetsTableAnnotationComposer,
    $$SnippetsTableCreateCompanionBuilder,
    $$SnippetsTableUpdateCompanionBuilder,
    (SnippetRow, BaseReferences<_$AppDatabase, $SnippetsTable, SnippetRow>),
    SnippetRow,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$QueryHistoryTableTableManager get queryHistory =>
      $$QueryHistoryTableTableManager(_db, _db.queryHistory);
  $$SnippetsTableTableManager get snippets =>
      $$SnippetsTableTableManager(_db, _db.snippets);
}
