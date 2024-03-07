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

class SavePreferences extends PreferencesEvent {
  SavePreferences({ 
    required this.preferences,
  });

  final Preferences preferences;

  @override
  List<Object?> get props => [preferences];
}