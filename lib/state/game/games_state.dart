part of 'games_bloc.dart';

class GamesState extends Equatable {
  const GamesState({
    this.phase = StatePhase.initial,
    this.games = const []
  });

  final StatePhase phase;
  final Iterable<Game> games;

  @override
  List<Object?> get props => [phase, games];

  GamesState copyWith({
    StatePhase? phase,
    Iterable<Game>? games,
  }) {
    return GamesState(
      phase: phase ?? this.phase,
      games: games ?? this.games,
    );
  }
}