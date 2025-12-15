import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_provider.freezed.dart';
part 'theme_provider.g.dart';

enum AppColorSource { official, dynamic, custom }

@freezed
abstract class ThemeSettings with _$ThemeSettings {
  const factory ThemeSettings({
    @Default(ThemeMode.system) ThemeMode themeMode,
    @Default(AppColorSource.official) AppColorSource colorSource,
    @Default(null) Color? customColor,
  }) = _ThemeSettings;
}

@Riverpod(keepAlive: true)
class ThemeController extends _$ThemeController {
  static const _keyThemeMode = 'theme_settings_mode';
  static const _keyColorSource = 'theme_settings_source';
  static const _keyCustomColor = 'theme_settings_custom_color';

  @override
  Future<ThemeSettings> build() async {
    return _loadSettings();
  }

  Future<ThemeSettings> _loadSettings() async {
    final prefs = SharedPreferencesAsync();

    final themeModeName = await prefs.getString(_keyThemeMode);
    final colorSourceName = await prefs.getString(_keyColorSource);
    final customColorValue = await prefs.getInt(_keyCustomColor);

    final themeMode = ThemeMode.values.firstWhere(
      (e) => e.name == themeModeName,
      orElse: () => ThemeMode.system,
    );

    final colorSource = AppColorSource.values.firstWhere(
      (e) => e.name == colorSourceName,
      orElse: () => AppColorSource.official,
    );

    Color? customColor;
    if (customColorValue != null) {
      customColor = Color(customColorValue);
    }

    return ThemeSettings(
      themeMode: themeMode,
      colorSource: colorSource,
      customColor: customColor,
    );
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = AsyncData(state.requireValue.copyWith(themeMode: mode));
    await SharedPreferencesAsync().setString(_keyThemeMode, mode.name);
  }

  Future<void> setColorSource(AppColorSource source) async {
    state = AsyncData(state.requireValue.copyWith(colorSource: source));
    await SharedPreferencesAsync().setString(_keyColorSource, source.name);
  }

  Future<void> setCustomColor(Color color) async {
    state = AsyncData(
      state.requireValue.copyWith(
        customColor: color,
        colorSource: AppColorSource.custom,
      ),
    );
    await SharedPreferencesAsync().setInt(_keyCustomColor, color.toARGB32());
    await SharedPreferencesAsync().setString(
      _keyColorSource,
      AppColorSource.custom.name,
    );
  }
}
