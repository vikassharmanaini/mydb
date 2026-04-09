import 'dart:convert';

/// Serializable editor session for crash recovery (tabs + SQL buffers).
///
/// On-disk schema: `agents/SESSION.md`.
final class SessionState {
  const SessionState({
    this.tabs = const <EditorTabSnapshot>[],
    this.activeTabId,
    this.scratchSql = '',
    this.scratchConnectionId,
  });

  final List<EditorTabSnapshot> tabs;
  final String? activeTabId;

  /// Single-editor SQL buffer (used when [tabs] is empty or as fallback).
  final String scratchSql;

  /// Which connection profile [scratchSql] belongs to.
  final String? scratchConnectionId;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'tabs': tabs.map((EditorTabSnapshot e) => e.toJson()).toList(),
        'activeTabId': activeTabId,
        'scratchSql': scratchSql,
        'scratchConnectionId': scratchConnectionId,
      };

  factory SessionState.fromJson(Map<String, dynamic> json) {
    final List<EditorTabSnapshot> out = <EditorTabSnapshot>[];
    final Object? rawTabs = json['tabs'];
    if (rawTabs is List<dynamic>) {
      for (final Object? e in rawTabs) {
        if (e is Map<String, dynamic>) {
          out.add(EditorTabSnapshot.fromJson(e));
        }
      }
    }
    return SessionState(
      tabs: out,
      activeTabId: json['activeTabId'] as String?,
      scratchSql: json['scratchSql'] as String? ?? '',
      scratchConnectionId: json['scratchConnectionId'] as String?,
    );
  }

  static SessionState decode(String source) {
    try {
      final Object? decoded = jsonDecode(source);
      if (decoded is Map<String, dynamic>) {
        return SessionState.fromJson(decoded);
      }
    } catch (_) {
      /* corrupt */
    }
    return const SessionState();
  }

  String encode() =>
      const JsonEncoder.withIndent('  ').convert(toJson());
}

final class EditorTabSnapshot {
  const EditorTabSnapshot({
    required this.id,
    this.connectionId,
    this.sql = '',
  });

  final String id;
  final String? connectionId;
  final String sql;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'connectionId': connectionId,
        'sql': sql,
      };

  factory EditorTabSnapshot.fromJson(Map<String, dynamic> json) {
    return EditorTabSnapshot(
      id: json['id'] as String? ?? '',
      connectionId: json['connectionId'] as String?,
      sql: json['sql'] as String? ?? '',
    );
  }
}
