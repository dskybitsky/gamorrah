import 'package:my_game_db/models/preferences/preferences.dart';

abstract class PreferencesRepository {
  Future<Preferences> get();

  Future<void> save(Preferences preferences);
}