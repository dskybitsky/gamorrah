part of 'preferences_bloc.dart';

enum PreferencesStatePhase { initial, success, error, loading }

extension PreferencesStatePhaseX on PreferencesStatePhase {
  bool get isInitial => this == PreferencesStatePhase.initial;
  bool get isSuccess => this == PreferencesStatePhase.success;
  bool get isError => this == PreferencesStatePhase.error;
  bool get isLoading => this == PreferencesStatePhase.loading;
}

class PreferencesState extends Equatable {
  const PreferencesState({
    this.phase = PreferencesStatePhase.initial,
    this.preferences = const Preferences(),
  });

  final PreferencesStatePhase phase;
  final Preferences preferences;

  @override
  List<Object?> get props => [phase, preferences];

  PreferencesState copyWith({
    PreferencesStatePhase? phase,
    Preferences? preferences,
  }) {
    return PreferencesState(
      phase: phase ?? this.phase,
      preferences: preferences ?? this.preferences,
    );
  }
}