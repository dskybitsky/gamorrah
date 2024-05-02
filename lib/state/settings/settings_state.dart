part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  const SettingsState({
    this.phase = StatePhase.initial,
    this.settings = const Settings(),
  });

  final StatePhase phase;
  final Settings settings;

  @override
  List<Object?> get props => [phase, settings];

  SettingsState copyWith({
    StatePhase? phase,
    Settings? settings,
  }) {
    return SettingsState(
      phase: phase ?? this.phase,
      settings: settings ?? this.settings,
    );
  }
}