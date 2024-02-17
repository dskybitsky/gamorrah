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