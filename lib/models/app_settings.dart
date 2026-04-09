import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_settings.freezed.dart';
part 'app_settings.g.dart';

@freezed
class AppSettings with _$AppSettings {
  const factory AppSettings({
    @Default(true) bool darkMode,
    @Default(13.0) double editorFontSize,
    @Default(4) int editorTabSize,
    @Default(false) bool editorLineWrap,
    @Default(true) bool editorAutocomplete,
    @Default(500) int gridPageSize,
    @Default('NULL') String gridNullDisplay,
    @Default('yyyy-MM-dd HH:mm:ss') String gridDateFormat,
    /// HTTP proxy URL for future driver HTTP modes (e.g. `http://host:8888`).
    @Default('') String httpProxyUrl,
    /// Reserved for shortcut customization (display / future keymap).
    @Default(true) bool showKeyboardShortcutHints,
  }) = _AppSettings;

  factory AppSettings.fromJson(Map<String, dynamic> json) =>
      _$AppSettingsFromJson(json);
}
