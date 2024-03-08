import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/models/preferences/preferences.dart';
import 'package:hive/hive.dart';

part 'hive_preferences.g.dart';

@HiveType(typeId: 1)
class HivePreferences extends HiveObject {
  HivePreferences({
    required this.gamesPresets,
  });

  @HiveField(0)
  final List<HiveGamesPreset> gamesPresets;

  factory HivePreferences.fromPreferences(Preferences preferences) => HivePreferences(
    gamesPresets: preferences.gamesPresets
      .map((e) => HiveGamesPreset.fromGamePreset(e))
      .toList(),
  );

  Preferences toPreferences() => Preferences(
    gamesPresets: gamesPresets
      .map((e) => e.toGamePreset()).toList(),
  );
}

@HiveType(typeId:11)
class HiveGamesPreset extends HiveObject {
  HiveGamesPreset({
    required this.name,
    required this.status,
    this.filter
  });

  @HiveField(0)
  final String name;

  @HiveField(1)
  final String status;

  @HiveField(2)
  final HiveGamesFilter? filter;

  factory HiveGamesPreset.fromGamePreset(GamesPreset gamesPreset) => HiveGamesPreset(
    name: gamesPreset.name,
    status: gamesPreset.status.name,
    filter: gamesPreset.filter != null
      ? HiveGamesFilter.fromGamesFilter(gamesPreset.filter!)
      : null,
  );

  GamesPreset toGamePreset() => GamesPreset(
    name: name,
    status: GameStatus.values.byName(status),
    filter: filter?.toGamesPageFilter(),
  );
}

@HiveType(typeId:12)
class HiveGamesFilter extends HiveObject {
  HiveGamesFilter({
    this.platforms,
    this.beaten
  });

  @HiveField(0)
  final List<String>? platforms;

  @HiveField(1)
  final String? beaten;

  factory HiveGamesFilter.fromGamesFilter(GamesFilter gamesFilter) => HiveGamesFilter(
    platforms: gamesFilter.platforms?.map((platform) => platform.name).toList(),
    beaten: gamesFilter.beaten?.name,
  );

  GamesFilter toGamesPageFilter() => GamesFilter(
    platforms: platforms != null 
      ? Set.from(platforms!.map((platformName) => GamePlatform.values.byName(platformName)))
      : null,
    beaten: beaten != null
      ? GamePersonalBeaten.values.byName(beaten!)
      : null,
  );
}