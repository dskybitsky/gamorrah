import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamorrah/models/games_view/games_view.dart';
import 'package:gamorrah/models/games_view/games_view_repository.dart';
import 'package:gamorrah/state/state_phase.dart';

part 'games_views_event.dart';
part 'games_views_state.dart';

class GamesViewsBloc extends Bloc<GamesViewsEvent, GamesViewsState> {
  GamesViewsBloc({
    required this.gamesViewRepository,
  }) : super(const GamesViewsState()) {
    on<LoadGamesViews>(_mapLoadGamesViewsEventToState);
    on<SaveGamesView>(_mapSaveGamesViewEventToState);
    on<DeleteGamesView>(_mapDeleteGamesViewEventToState);
  }

  final GamesViewRepository gamesViewRepository;

  void _mapLoadGamesViewsEventToState(
    LoadGamesViews event, 
    Emitter<GamesViewsState> emit
  ) async {
    try {
      emit(state.copyWith(phase: StatePhase.loading));

      final gamesViews = await gamesViewRepository.get();

      emit(state.copyWith(
        phase: StatePhase.success,
        gamesViews: List.from(gamesViews),
      ));
    } catch (error, stacktrace) {
      print(error);
      print(stacktrace);
      emit(state.copyWith(phase: StatePhase.error));
    }
  }

  void _mapSaveGamesViewEventToState(
    SaveGamesView event,
    Emitter<GamesViewsState> emit
  ) async {
    try {
      await gamesViewRepository.save(event.gamesView);

      emit(state.copyWith(
        phase: StatePhase.success,
      ));
    } catch (error, stacktrace) {
      print(error);
      print(stacktrace);
      emit(state.copyWith(phase: StatePhase.error));
    }
  }

  void _mapDeleteGamesViewEventToState(
    DeleteGamesView event,
    Emitter<GamesViewsState> emit
  ) async {
    try {
      await gamesViewRepository.delete(event.id);

      emit(state.copyWith(
        phase: StatePhase.success,
      ));
    } catch (error, stacktrace) {
      print(stacktrace);
      emit(state.copyWith(phase: StatePhase.error));
    }
  }
}