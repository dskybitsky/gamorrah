part of 'games_views_bloc.dart';

class GamesViewsState extends Equatable {
  const GamesViewsState({
    this.phase = StatePhase.initial,
    this.gamesViews = const [],
  });

  final StatePhase phase;
  final List<GamesView> gamesViews;

  @override
  List<Object?> get props => [phase, gamesViews];

  GamesViewsState copyWith({
    StatePhase? phase,
    List<GamesView>? gamesViews,
  }) {
    return GamesViewsState(
      phase: phase ?? this.phase,
      gamesViews: gamesViews ?? this.gamesViews,
    );
  }
}