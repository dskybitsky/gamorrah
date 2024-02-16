part of 'games_bloc.dart';

enum GamesStatePhase { initial, success, error, loading }

extension GamesStatePhaseX on GamesStatePhase {
  bool get isInitial => this == GamesStatePhase.initial;
  bool get isSuccess => this == GamesStatePhase.success;
  bool get isError => this == GamesStatePhase.error;
  bool get isLoading => this == GamesStatePhase.loading;
}

class GamesState extends Equatable {
  const GamesState({
    this.phase = GamesStatePhase.initial,
    this.games = const [],
    this.status = GameStatus.playing,
  });

  final GamesStatePhase phase;
  final Iterable<Game> games;
  final GameStatus status;

  @override
  List<Object?> get props => [games];

  GamesState copyWith({
    GamesStatePhase? phase,
    Iterable<Game>? games,
    GameStatus? status,
  }) {
    return GamesState(
      phase: phase ?? this.phase,
      games: games ?? this.games,
      status: status ?? this.status,
    );
  }
}