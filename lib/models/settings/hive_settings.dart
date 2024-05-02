import 'dart:convert';

import 'package:json_theme/json_theme.dart';
import 'package:my_game_db/models/settings/settings.dart';
import 'package:hive/hive.dart';

part 'hive_settings.g.dart';

@HiveType(typeId: 200)
class HiveSettings extends HiveObject {
  HiveSettings({
    required this.theme,
    this.darkTheme
  });

  @HiveField(0)
  final String theme;

  @HiveField(1)
  final String? darkTheme;

  factory HiveSettings.fromSettings(Settings settings) {
    final encodedThemeData = ThemeEncoder.encodeThemeData(settings.theme);
    final encodedDarkThemeData = settings.darkTheme != null 
      ? ThemeEncoder.encodeThemeData(settings.darkTheme)
      : null;

    return HiveSettings(
      theme: jsonEncode(encodedThemeData),
      darkTheme: encodedDarkThemeData != null ? jsonEncode(encodedDarkThemeData) : null
    );
  }

  Settings toSettings() {
    final encodedThemeData = jsonDecode(theme);
    final encodedDarkThemeData = darkTheme != null ? jsonDecode(darkTheme!) : null;

    return Settings(
      theme: ThemeDecoder.decodeThemeData(encodedThemeData)!,
      darkTheme: encodedDarkThemeData != null
        ? ThemeDecoder.decodeThemeData(encodedDarkThemeData)
        : null,
    );
  }
}
