# Session persistence (`session.json`)

Stored under application support `dbstudio/session.json` via [SessionRestoreService](../lib/services/session_restore_service.dart).

## JSON shape

```json
{
  "tabs": [
    {
      "id": "uuid",
      "connectionId": "profile-uuid or null",
      "sql": "SELECT ..."
    }
  ],
  "activeTabId": "uuid or null",
  "scratchSql": "optional single-editor buffer when tabs are empty",
  "scratchConnectionId": "profile-uuid or null"
}
```

- **tabs** / **activeTabId**: multi-tab editor (when implemented).
- **scratchSql** / **scratchConnectionId**: restores the main query editor for one connection until full tab state exists.

Unknown keys are ignored on load for forward compatibility.
