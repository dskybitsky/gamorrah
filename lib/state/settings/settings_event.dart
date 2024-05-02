part of 'settings_bloc.dart';

class SettingsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadSettings extends SettingsEvent {
  LoadSettings();

  @override
  List<Object?> get props => [];
}

class SaveSettings extends SettingsEvent {
  SaveSettings({ 
    required this.settings,
  });

  final Settings settings;

  @override
  List<Object?> get props => [settings];
}