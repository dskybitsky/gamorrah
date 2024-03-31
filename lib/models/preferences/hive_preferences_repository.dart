import 'package:flutter/foundation.dart';
import 'package:gamorrah/models/preferences/preferences.dart';
import 'package:gamorrah/models/preferences/preferences_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'hive_preferences.dart';

class HivePreferencesRepository extends PreferencesRepository {
  static const boxName = kDebugMode
    ? 'preferences:v:02:debug'
    : 'preferences:v:02';

  Box<HivePreferences>? _box;

  @override
  Future<Preferences> get() async {
    final box = await _getBox();
    final first = box.values.firstOrNull;

    if (first != null) {
      return first.toPreferences();
    }

    return Preferences();
  }

  @override
  Future<void> save(Preferences preferences) async {
    final box = await _getBox();

    await box.put(0, HivePreferences.fromPreferences(preferences));
  }

  Future<Box<HivePreferences>> _getBox() async {
    if (_box == null) {
      await _init();
    }

    return _box!;
  }

  _init() async {
    _box = await Hive.openBox(boxName);
  }
}