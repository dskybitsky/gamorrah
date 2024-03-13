part of 'preferences_bloc.dart';

class PreferencesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadPrefernces extends PreferencesEvent {
  LoadPrefernces();

  @override
  List<Object?> get props => [];
}

class SaveGamesPreset extends PreferencesEvent {
  SaveGamesPreset({ 
    required this.gamesPreset,
  });

  final GamesPreset gamesPreset;

  @override
  List<Object?> get props => [gamesPreset];
}