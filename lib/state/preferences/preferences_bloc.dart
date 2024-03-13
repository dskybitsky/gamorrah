import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamorrah/models/optional.dart';
import 'package:gamorrah/models/preferences/preferences.dart';
import 'package:gamorrah/models/preferences/preferences_repository.dart';

part 'preferences_event.dart';
part 'preferences_state.dart';

class PreferencesBloc extends Bloc<PreferencesEvent, PreferencesState> {
  PreferencesBloc({
    required this.preferencesRepository,
  }) : super(const PreferencesState()) {
    on<LoadPrefernces>(_mapLoadPreferencesEventToState);
    on<SaveGamesPreset>(_mapSaveGamesPresetEventToState);
  }

  final PreferencesRepository preferencesRepository;

  void _mapLoadPreferencesEventToState(
    LoadPrefernces event, 
    Emitter<PreferencesState> emit
  ) async {
    try {
      emit(state.copyWith(phase: PreferencesStatePhase.loading));

      final preferences = await preferencesRepository.get();

      emit(state.copyWith(
        phase: PreferencesStatePhase.success,
        preferences: preferences,
      ));
    } catch (error, stacktrace) {
      print(error);
      print(stacktrace);
      emit(state.copyWith(phase: PreferencesStatePhase.error));
    }
  }

  void _mapSaveGamesPresetEventToState(
    SaveGamesPreset event,
    Emitter<PreferencesState> emit
  ) async {
    try {
      emit(state.copyWith(phase: PreferencesStatePhase.loading));

      final gamesPresets = state.preferences.gamesPresets
        .whereNot((gamesPreset) => gamesPreset.name == event.gamesPreset.name)
        .toList();

      gamesPresets.add(event.gamesPreset);

      final preferences = state.preferences.copyWith(gamesPresets: Optional(gamesPresets));

      await preferencesRepository.save(preferences);

      emit(state.copyWith(
        phase: PreferencesStatePhase.success,
      ));
    } catch (error, stacktrace) {
      print(error);
      print(stacktrace);
      emit(state.copyWith(phase: PreferencesStatePhase.error));
    }
  }
}