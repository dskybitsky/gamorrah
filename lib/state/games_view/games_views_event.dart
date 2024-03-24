part of 'games_views_bloc.dart';

class GamesViewsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadGamesViews extends GamesViewsEvent {
  LoadGamesViews();

  @override
  List<Object?> get props => [];
}

class SaveGamesView extends GamesViewsEvent {
  SaveGamesView({ 
    required this.gamesView,
  });

  final GamesView gamesView;

  @override
  List<Object?> get props => [gamesView];
}

class DeleteGamesView extends GamesViewsEvent {
  DeleteGamesView({
    required this.id,
  });

  final String id;

  @override
  List<Object?> get props => [id];
}