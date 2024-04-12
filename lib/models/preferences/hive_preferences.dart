import 'package:my_game_db/models/preferences/preferences.dart';
import 'package:hive/hive.dart';

part 'hive_preferences.g.dart';

@HiveType(typeId: 200)
class HivePreferences extends HiveObject {
  HivePreferences({
    this.dataDir,
  });

  @HiveField(0)
  final String? dataDir;

  factory HivePreferences.fromPreferences(Preferences preferences) => HivePreferences(
    dataDir: preferences.dataDir,
  );

  Preferences toPreferences() => Preferences(
    dataDir: dataDir,
  );
}
