import 'package:gamorrah/models/game/game.dart';

class Preferences {
  const Preferences({
    this.gamesPagePresets = const[],
  });

  final List<GamesPagePreset> gamesPagePresets;
}

class GamesPagePreset {
  GamesPagePreset({
    required this.name,
    required this.status,
    this.filter,
  });

  final String name;
  final GameStatus status;
  final GamesPageFilter? filter;
}

class GamesPageFilter {
  GamesPageFilter({
    this.platforms,
    this.beaten
  });
  
  final Set<GamePlatform>? platforms;
  final GamePersonalBeaten? beaten;
}