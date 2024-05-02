import 'package:my_game_db/models/settings/settings.dart';

abstract class SettingsRepository {
  Future<Settings> get();

  Future<void> save(Settings settings);
}