part of 'preferences_bloc.dart';

class PreferencesState extends Equatable {
  const PreferencesState({
    this.phase = StatePhase.initial,
    this.preferences = const Preferences(),
  });

  final StatePhase phase;
  final Preferences preferences;

  @override
  List<Object?> get props => [phase, preferences];

  PreferencesState copyWith({
    StatePhase? phase,
    Preferences? preferences,
  }) {
    return PreferencesState(
      phase: phase ?? this.phase,
      preferences: preferences ?? this.preferences,
    );
  }
}