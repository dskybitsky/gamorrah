import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/models/optional.dart';
import 'package:uuid/uuid.dart';

class GamesView {
  GamesView({
    required this.id,
    required this.name,
    required this.status,
    this.index = 0,
    this.filter,
  });

  final String id;
  final String name;
  final GameStatus status;
  final int index;
  final GamesFilter? filter;

  factory GamesView.create({
    String? id,
    required String name,
    required GameStatus status,
    int index = 0,
    GamesFilter? filter,
  }) => GamesView(
    id: id ?? const Uuid().v4(),
    name: name, 
    status: status,
    index: index,
    filter: filter,
  );

  GamesView copyWith({
    Optional<String>? name,
    Optional<GameStatus>? status,
    Optional<int>? index,
    Optional<GamesFilter?>? filter,
  }) => GamesView.create(
    id: id,
    name: name != null ? name.value : this.name,
    status: status != null ? status.value : this.status,
    index: index != null ? index.value : this.index,
    filter: filter != null ? filter.value : this.filter,
  );
}

class GamesFilter {
  GamesFilter({
    this.platforms,
    this.beaten,
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