import 'dart:convert';

/// Serializable editor session for crash recovery (tabs + SQL buffers).
final class SessionState {
  const SessionState({
    this.tabs = const <EditorTabSnapshot>[],
    this.activeTabId,
  });

  final List<EditorTabSnapshot> tabs;
  final String? activeTabId;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'tabs': tabs.map((EditorTabSnapshot e) => e.toJson()).toList(),
        'activeTabId': activeTabId,
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
