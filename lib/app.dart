import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mydb/app_router.dart';
import 'package:mydb/models/app_settings.dart';
import 'package:mydb/state/settings_controller.dart';

class DBStudioApp extends ConsumerWidget {
  const DBStudioApp({super.key});

  static ThemeData _themeFromSettings(AppSettings s) {
    final Brightness brightness =
        s.darkMode ? Brightness.dark : Brightness.light;
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF1565C0),
      brightness: brightness,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GoRouter router = ref.watch(goRouterProvider);
    final AsyncValue<AppSettings> settingsAsync =
        ref.watch(appSettingsControllerProvider);
    return settingsAsync.when(
      data: (AppSettings s) {
        final double textScale = s.editorFontSize / 14.0;
        return MaterialApp.router(
          title: 'DBStudio',
          theme: _themeFromSettings(s),
          routerConfig: router,
          builder: (BuildContext context, Widget? child) {
            final MediaQueryData m = MediaQuery.of(context);
            return MediaQuery(
              data: m.copyWith(
                textScaler: TextScaler.linear(textScale),
              ),
              child: child ?? const SizedBox.shrink(),
            );
          },
        );
      },
      loading: () => MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF1565C0),
            brightness: Brightness.dark,
          ),
        ),
        home: const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      ),
      error: (Object e, StackTrace _) => MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF1565C0),
            brightness: Brightness.dark,
          ),
        ),
        home: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text('Could not load settings: $e'),
            ),
          ),
        ),
      ),
    );
  }
}
