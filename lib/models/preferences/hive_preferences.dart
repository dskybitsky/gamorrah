import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/models/preferences/preferences.dart';
import 'package:hive/hive.dart';

part 'hive_preferences.g.dart';

@HiveType(typeId: 1)
class HivePreferences extends HiveObject {
  HivePreferences({
    required this.gamesPagePresets,
  });

  @HiveField(0)
  final List<HiveGamesPagePreset> gamesPagePresets;

  factory HivePreferences.fromPreferences(Preferences preferences) => HivePreferences(
    gamesPagePresets: preferences.gamesPagePresets
      .map((e) => HiveGamesPagePreset.fromGamePagePreset(e))
      .toList(),
  );

  Preferences toPreferences() => Preferences(
    gamesPagePresets: gamesPagePresets
      .map((e) => e.toGamePagePreset()).toList(),
  );
}

@HiveType(typeId:11)
class HiveGamesPagePreset extends HiveObject {
  HiveGamesPagePreset({
    required this.name,
    required this.status,
    this.filter
  });

  @HiveField(0)
  final String name;

  @HiveField(1)
  final String status;

  @HiveField(2)
  final HiveGamesPageFilter? filter;

  factory HiveGamesPagePreset.fromGamePagePreset(GamesPagePreset gamesPagePreset) => HiveGamesPagePreset(
    name: gamesPagePreset.name,
    status: gamesPagePreset.status.name,
    filter: gamesPagePreset.filter != null
      ? HiveGamesPageFilter.fromGamesPageFilter(gamesPagePreset.filter!)
      : null,
  );

  GamesPagePreset toGamePagePreset() => GamesPagePreset(
    name: name,
    status: GameStatus.values.byName(status),
    filter: filter?.toGamesPageFilter(),
  );
}

@HiveType(typeId:12)
class HiveGamesPageFilter extends HiveObject {
  HiveGamesPageFilter({
    this.platforms,
    this.beaten
  });

  @HiveField(0)
  final List<String>? platforms;

  @HiveField(1)
  final String? beaten;

  factory HiveGamesPageFilter.fromGamesPageFilter(GamesPageFilter gamesPageFilter) => HiveGamesPageFilter(
    platforms: gamesPageFilter.platforms?.map((platform) => platform.name).toList(),
    beaten: gamesPageFilter.beaten?.name,
  );

  GamesPageFilter toGamesPageFilter() => GamesPageFilter(
    platforms: platforms != null 
      ? Set.from(platforms!.map((platformName) => GamePlatform.values.byName(platformName)))
      : null,
    beaten: beaten != null
      ? GamePersonalBeaten.values.byName(beaten!)
      : null,
  );
}