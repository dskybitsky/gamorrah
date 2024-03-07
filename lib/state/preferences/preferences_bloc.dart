import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamorrah/models/preferences/preferences.dart';
import 'package:gamorrah/models/preferences/preferences_repository.dart';

part 'preferences_event.dart';
part 'preferences_state.dart';

class PreferencesBloc extends Bloc<PreferencesEvent, PreferencesState> {
  PreferencesBloc({
    required this.preferencesRepository,
  }) : super(const PreferencesState()) {
    on<LoadPrefernces>(_mapLoadPreferencesEventToState);
    on<SavePreferences>(_mapSavePreferencesEventToState);
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
      print(stacktrace);
      emit(state.copyWith(phase: PreferencesStatePhase.error));
    }
  }

  void _mapSavePreferencesEventToState(
    SavePreferences event,
    Emitter<PreferencesState> emit
  ) async {
    try {
      emit(state.copyWith(phase: PreferencesStatePhase.loading));

      await preferencesRepository.save(event.preferences);

      emit(state.copyWith(
        phase: PreferencesStatePhase.success,
      ));
    } catch (error, stacktrace) {
      print(stacktrace);
      emit(state.copyWith(phase: PreferencesStatePhase.error));
    }
  }
}