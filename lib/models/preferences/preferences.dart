import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/models/optional.dart';

class Preferences {
  const Preferences({
    this.gamesPresets = const[],
  });

  final List<GamesPreset> gamesPresets;
}

class GamesPreset {
  GamesPreset({
    required this.name,
    required this.status,
    this.filter,
  });

  final String name;
  final GameStatus status;
  final GamesFilter? filter;
}

class GamesFilter {
  GamesFilter({
    this.platforms,
    this.beaten
  });
  
  final Set<GamePlatform>? platforms;
  final GamePersonalBeaten? beaten;

  GamesFilter copyWith({
    Optional<Set<GamePlatform>?>? platforms,
    Optional<GamePersonalBeaten?>? beaten
  }) => GamesFilter(
    platforms: platforms != null ? platforms.value : this.platforms,
    beaten: beaten != null ? beaten.value : this.beaten,
  );

  bool matches(Game game) {
    if (beaten != null && beaten != game.personal?.beaten) {
      return false;
    }

    if (platforms != null && platforms!.intersection(game.platforms).isEmpty) {
      return false;
    }

    return true;
  }

  bool get isEmpty => 
    beaten == null
    && platforms == null;
}