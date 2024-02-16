part of 'games_bloc.dart';

class GamesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetGames extends GamesEvent {
  GetGames({
    required this.status,
  });

  final GameStatus status;

  @override
  List<Object?> get props => [status];
}

class SaveGame extends GamesEvent {
  SaveGame({ 
    required this.game,
  });

  final Game game;

  @override
  List<Object?> get props => [game];
}