import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/models/games_view/games_view.dart';
import 'package:hive/hive.dart';

part 'hive_games_view.g.dart';

@HiveType(typeId:1)
class HiveGamesView extends HiveObject {
  HiveGamesView({
    required this.id,
    required this.name,
    required this.status,
    this.index = 0,
    this.filter
  });

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String status;

  @HiveField(3)
  final int index;

  @HiveField(4)
  final HiveGamesFilter? filter;

  factory HiveGamesView.fromGamesView(GamesView gamesView) => HiveGamesView(
    id: gamesView.id,
    name: gamesView.name,
    status: gamesView.status.name,
    index: gamesView.index,
    filter: gamesView.filter != null
      ? HiveGamesFilter.fromGamesFilter(gamesView.filter!)
      : null,
  );

  GamesView toGamesView() => GamesView(
    id: id,
    name: name,
    status: GameStatus.values.byName(status),
    index: index,
    filter: filter?.toGamesPageFilter(),
  );
}

@HiveType(typeId:11)
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