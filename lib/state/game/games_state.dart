part of 'games_bloc.dart';

class GamesState extends Equatable {
  const GamesState({
    this.phase = StatePhase.initial,
    this.games = const [],
    this.tags = const {},
  });

  final StatePhase phase;
  final Iterable<Game> games;
  final Set<String> tags;

  @override
  List<Object?> get props => [phase, games, tags];

  GamesState copyWith({
    StatePhase? phase,
    Iterable<Game>? games,
    Set<String>? tags,
  }) {
    return GamesState(
      phase: phase ?? this.phase,
      games: games ?? this.games,
      tags: tags ?? this.tags
    );
  }
}