import 'package:flutter/material.dart';
import 'package:my_game_db/models/optional.dart';

class Settings {
  const Settings({
    this.theme,
    this.darkTheme
  });

  final ThemeData? theme;
  final ThemeData? darkTheme;

  Settings copyWith({
    Optional<ThemeData?>? theme,
    Optional<ThemeData?>? darkTheme,
  }) => Settings(
    theme: theme != null ? theme.value : this.theme,
    darkTheme: darkTheme != null ? darkTheme.value : this.darkTheme,
  );
}
