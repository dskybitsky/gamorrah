import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_game_db/models/settings/settings.dart';
import 'package:my_game_db/models/settings/settings_repository.dart';
import 'package:my_game_db/state/state_phase.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({
    required this.settingsRepository,
  }) : super(const SettingsState()) {
    on<LoadSettings>(_mapLoadSettingsEventToState);
    on<SaveSettings>(_mapSaveSettingsEventToState);
  }

  final SettingsRepository settingsRepository;

  void _mapLoadSettingsEventToState(
    LoadSettings event, 
    Emitter<SettingsState> emit
  ) async {
    try {
      final settings = await settingsRepository.get();

      emit(state.copyWith(
        phase: StatePhase.success,
        settings: settings,
      ));
    } catch (error, stacktrace) {
      print(error);
      print(stacktrace);
      emit(state.copyWith(phase: StatePhase.error));
    }
  }

  void _mapSaveSettingsEventToState(
    SaveSettings event,
    Emitter<SettingsState> emit
  ) async {
    try {
      await settingsRepository.save(event.settings);

      emit(state.copyWith(
        phase: StatePhase.success,
        settings: event.settings
      ));
    } catch (error, stacktrace) {
      print(error);
      print(stacktrace);
      emit(state.copyWith(phase: StatePhase.error));
    }
  }
}