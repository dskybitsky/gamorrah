part of 'games_bloc.dart';

class GamesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadGames extends GamesEvent {
  LoadGames();

  @override
  List<Object?> get props => [];
}

class SaveGame extends GamesEvent {
  SaveGame({ 
    required this.game,
  });

  final Game game;

  @override
  List<Object?> get props => [game];
}

class SaveGames extends GamesEvent {
  SaveGames({ 
    required this.games,
  });

  final Iterable<Game> games;

  @override
  List<Object?> get props => [games];
}

class DeleteGame extends GamesEvent {
  DeleteGame({
    required this.id,
  });

  final String id;

  @override
  List<Object?> get props => [id];
}

class DeleteAllGames extends GamesEvent {
  DeleteAllGames();

  @override
  List<Object?> get props => [];
}