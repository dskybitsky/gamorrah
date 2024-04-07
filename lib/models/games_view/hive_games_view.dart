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
    this.beaten,
    this.howLongToBeat
  });

  @HiveField(0)
  final HiveGamesFilterPlatformsPredicate? platforms;

  @HiveField(1)
  final HiveGamesFilterBeatenPredicate? beaten;

  @HiveField(2)
  final HiveGamesFilterHowLongToBeatPredicate? howLongToBeat;

  factory HiveGamesFilter.fromGamesFilter(GamesFilter gamesFilter) => HiveGamesFilter(
    platforms: gamesFilter.platforms != null
      ? HiveGamesFilterPlatformsPredicate.fromGamesFilterPlatformsPredicate(gamesFilter.platforms!)
      : null,
    beaten: gamesFilter.beaten != null
      ? HiveGamesFilterBeatenPredicate.fromGamesFilterBeatenPredicate(gamesFilter.beaten!)
      : null,
    howLongToBeat: gamesFilter.howLongToBeat != null
      ? HiveGamesFilterHowLongToBeatPredicate.fromGamesFilterBeatenPredicate(gamesFilter.howLongToBeat!)
      : null,
  );

  GamesFilter toGamesPageFilter() => GamesFilter(
    platforms: platforms?.toGamesFilterPlatformsPredicate(),
    beaten: beaten?.toGamesFilterBeatenPredicate(),
    howLongToBeat: howLongToBeat?.toGamesFilterHowLongToBeatPredicate(),
  );
}

@HiveType(typeId:12)
class HiveGamesFilterPlatformsPredicate {
  HiveGamesFilterPlatformsPredicate({
    required this.operator,
    required this.value,
  });

  @HiveField(0)
  final String operator;

  @HiveField(1)
  final List<String> value;

  factory HiveGamesFilterPlatformsPredicate.fromGamesFilterPlatformsPredicate(
    GamesFilterPlatformsPredicate gamesFilterPlatformsPredicate
  ) => HiveGamesFilterPlatformsPredicate(
    operator: gamesFilterPlatformsPredicate.operator.name,
    value: gamesFilterPlatformsPredicate.value.map((platform) => platform.name).toList(),
  );

  GamesFilterPlatformsPredicate toGamesFilterPlatformsPredicate() => GamesFilterPlatformsPredicate(
    operator: GamesFilterPlatformsOperator.values.byName(operator),
    value: Set.from(value.map((platformName) => GamePlatform.values.byName(platformName)))
  );
}

@HiveType(typeId:13)
class HiveGamesFilterBeatenPredicate {
  HiveGamesFilterBeatenPredicate({
    required this.operator,
    required this.value,
  });

  @HiveField(0)
  final String operator;

  @HiveField(1)
  final String? value;

  factory HiveGamesFilterBeatenPredicate.fromGamesFilterBeatenPredicate(
    GamesFilterBeatenPredicate gamesFilterBeatenPredicate
  ) => HiveGamesFilterBeatenPredicate(
    operator: gamesFilterBeatenPredicate.operator.name,
    value: gamesFilterBeatenPredicate.value?.name,
  );

  GamesFilterBeatenPredicate toGamesFilterBeatenPredicate() => GamesFilterBeatenPredicate(
    operator: GamesFilterBeatenOperator.values.byName(operator),
    value: value != null
      ? GamePersonalBeaten.values.byName(value!)
      : null
  );
}

@HiveType(typeId:15)
class HiveGamesFilterHowLongToBeatPredicate {
  HiveGamesFilterHowLongToBeatPredicate({
    required this.operator,
    required this.field,
    required this.value,
  });

  @HiveField(0)
  final String operator;
  
  @HiveField(1)
  final String field;
  
  @HiveField(2)
  final double value;

  factory HiveGamesFilterHowLongToBeatPredicate.fromGamesFilterBeatenPredicate(
    GamesFilterHowLongToBeatPredicate gamesFilterHowLongToBeatPredicate
  ) => HiveGamesFilterHowLongToBeatPredicate(
    operator: gamesFilterHowLongToBeatPredicate.operator.name,
    field: gamesFilterHowLongToBeatPredicate.field.name,
    value: gamesFilterHowLongToBeatPredicate.value,
  );

  GamesFilterHowLongToBeatPredicate toGamesFilterHowLongToBeatPredicate() => GamesFilterHowLongToBeatPredicate(
    operator: GamesFilterHowLongToBeatOperator.values.byName(operator),
    field: GamesFilterHowLongToBeatField.values.byName(field),
    value: value
  );
}