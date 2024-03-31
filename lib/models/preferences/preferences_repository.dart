import 'package:gamorrah/models/preferences/preferences.dart';

abstract class PreferencesRepository {
  Future<Preferences> get();

  Future<void> save(Preferences preferences);
}