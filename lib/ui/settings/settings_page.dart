import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mydb/models/app_settings.dart';
import 'package:mydb/state/settings_controller.dart';

/// Application preferences backed by [AppSettingsRepository].
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  Future<void> _editString(
    BuildContext context,
    WidgetRef ref, {
    required String title,
    required String initial,
    required void Function(String v) onSave,
  }) async {
    final TextEditingController t = TextEditingController(text: initial);
    final String? out = await showDialog<String>(
      context: context,
      builder: (BuildContext c) => AlertDialog(
        title: Text(title),
        content: TextField(
          controller: t,
          autofocus: true,
          onSubmitted: (String v) => Navigator.pop(c, v),
        ),
        actions: <Widget>[
          TextButton(onPressed: () => Navigator.pop(c), child: const Text('Cancel')),
          FilledButton(
            onPressed: () => Navigator.pop(c, t.text),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    t.dispose();
    if (out != null) {
      onSave(out.trim());
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<AppSettings> async = ref.watch(appSettingsControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (Object e, StackTrace _) => Center(child: Text('$e')),
        data: (AppSettings s) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: <Widget>[
              Text('Appearance', style: Theme.of(context).textTheme.titleMedium),
              SwitchListTile(
                title: const Text('Dark mode'),
                value: s.darkMode,
                onChanged: (bool v) =>
                    ref.read(appSettingsControllerProvider.notifier).setDarkMode(v),
              ),
              const Divider(),
              Text('Editor', style: Theme.of(context).textTheme.titleMedium),
              ListTile(
                title: const Text('Font size'),
                subtitle: Slider(
                  value: s.editorFontSize.clamp(10, 24),
                  min: 10,
                  max: 24,
                  divisions: 14,
                  label: s.editorFontSize.toStringAsFixed(0),
                  onChanged: (double v) => ref
                      .read(appSettingsControllerProvider.notifier)
                      .setEditorFontSize(v),
                ),
              ),
              ListTile(
                title: const Text('Tab width (spaces)'),
                subtitle: Slider(
                  value: s.editorTabSize.toDouble().clamp(2, 8),
                  min: 2,
                  max: 8,
                  divisions: 6,
                  label: '${s.editorTabSize}',
                  onChanged: (double v) => ref
                      .read(appSettingsControllerProvider.notifier)
                      .patch((AppSettings x) => x.copyWith(editorTabSize: v.round())),
                ),
              ),
              SwitchListTile(
                title: const Text('Line wrap in SQL editor'),
                value: s.editorLineWrap,
                onChanged: (bool v) => ref
                    .read(appSettingsControllerProvider.notifier)
                    .patch((AppSettings x) => x.copyWith(editorLineWrap: v)),
              ),
              SwitchListTile(
                title: const Text('Autocomplete (schema-driven)'),
                value: s.editorAutocomplete,
                onChanged: (bool v) => ref
                    .read(appSettingsControllerProvider.notifier)
                    .patch((AppSettings x) => x.copyWith(editorAutocomplete: v)),
              ),
              const Divider(),
              Text('Grid', style: Theme.of(context).textTheme.titleMedium),
              ListTile(
                title: const Text('Page size (max rows per fetch)'),
                subtitle: Slider(
                  value: s.gridPageSize.toDouble().clamp(100, 5000),
                  min: 100,
                  max: 5000,
                  divisions: 49,
                  label: '${s.gridPageSize}',
                  onChanged: (double v) => ref
                      .read(appSettingsControllerProvider.notifier)
                      .patch(
                        (AppSettings x) => x.copyWith(gridPageSize: v.round()),
                      ),
                ),
              ),
              ListTile(
                title: const Text('NULL display'),
                subtitle: Text(s.gridNullDisplay),
                trailing: const Icon(Icons.edit),
                onTap: () => _editString(
                  context,
                  ref,
                  title: 'NULL display',
                  initial: s.gridNullDisplay,
                  onSave: (String v) => ref
                      .read(appSettingsControllerProvider.notifier)
                      .patch((AppSettings x) => x.copyWith(gridNullDisplay: v)),
                ),
              ),
              ListTile(
                title: const Text('Date format hint'),
                subtitle: Text(s.gridDateFormat),
                trailing: const Icon(Icons.edit),
                onTap: () => _editString(
                  context,
                  ref,
                  title: 'Date format',
                  initial: s.gridDateFormat,
                  onSave: (String v) => ref
                      .read(appSettingsControllerProvider.notifier)
                      .patch((AppSettings x) => x.copyWith(gridDateFormat: v)),
                ),
              ),
              const Divider(),
              Text('Network', style: Theme.of(context).textTheme.titleMedium),
              ListTile(
                title: const Text('HTTP proxy URL'),
                subtitle: Text(
                  s.httpProxyUrl.isEmpty ? '(none)' : s.httpProxyUrl,
                ),
                trailing: const Icon(Icons.edit),
                onTap: () => _editString(
                  context,
                  ref,
                  title: 'HTTP proxy',
                  initial: s.httpProxyUrl,
                  onSave: (String v) => ref
                      .read(appSettingsControllerProvider.notifier)
                      .patch((AppSettings x) => x.copyWith(httpProxyUrl: v)),
                ),
              ),
              const Divider(),
              Text('Shortcuts', style: Theme.of(context).textTheme.titleMedium),
              SwitchListTile(
                title: const Text('Show keyboard shortcut hints'),
                value: s.showKeyboardShortcutHints,
                onChanged: (bool v) => ref
                    .read(appSettingsControllerProvider.notifier)
                    .patch(
                      (AppSettings x) =>
                          x.copyWith(showKeyboardShortcutHints: v),
                    ),
              ),
            ],
          );
        },
      ),
    );
  }
}
