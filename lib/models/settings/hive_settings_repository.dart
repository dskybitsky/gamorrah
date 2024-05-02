import 'package:flutter/foundation.dart';
import 'package:my_game_db/models/settings/settings.dart';
import 'package:my_game_db/models/settings/settings_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'hive_settings.dart';

class HiveSettingsRepository extends SettingsRepository {
  static const boxName = kDebugMode
    ? 'preferences:v:02:debug'
    : 'preferences:v:02';

  Box<HiveSettings>? _box;

  @override
  Future<Settings> get() async {
    final box = await _getBox();
    final first = box.values.firstOrNull;

    if (first != null) {
      return first.toSettings();
    }

    return Settings();
  }

  @override
  Future<void> save(Settings settings) async {
    final box = await _getBox();

    await box.put(0, HiveSettings.fromSettings(settings));
  }

  Future<Box<HiveSettings>> _getBox() async {
    if (_box == null) {
      await _init();
    }

    return _box!;
  }

  _init() async {
    _box = await Hive.openBox(boxName);
  }
}