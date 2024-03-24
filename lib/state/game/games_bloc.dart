import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/models/game/game_repository.dart';
import 'package:gamorrah/state/state_phase.dart';

part 'games_event.dart';
part 'games_state.dart';

class GamesBloc extends Bloc<GamesEvent, GamesState> {
  GamesBloc({
    required this.gameRepository,
  }) : super(const GamesState()) {
    on<LoadGames>(_mapLoadGamesEventToState);
    on<SaveGame>(_mapSaveGameEventToState);
    on<SaveGames>(_mapSaveGamesEventToState);
    on<DeleteGame>(_mapDeleteGameEventToState);
    on<DeleteAllGames>(_mapDeleteAllGamesEventToState);
  }

  final GameRepository gameRepository;

  void _mapLoadGamesEventToState(
    LoadGames event, 
    Emitter<GamesState> emit
  ) async {
    try {
      emit(state.copyWith(phase: StatePhase.loading));

      final games = await gameRepository.get();

      emit(state.copyWith(
        phase: StatePhase.success,
        games: games,
      ));
    } catch (error, stacktrace) {
      print(stacktrace);
      emit(state.copyWith(phase: StatePhase.error));
    }
  }

  void _mapSaveGameEventToState(
    SaveGame event,
    Emitter<GamesState> emit
  ) async {
    try {
      emit(state.copyWith(phase: StatePhase.loading));

      await gameRepository.save(event.game);

      emit(state.copyWith(
        phase: StatePhase.success,
      ));
    } catch (error, stacktrace) {
      print(stacktrace);
      emit(state.copyWith(phase: StatePhase.error));
    }
  }

  void _mapSaveGamesEventToState(
    SaveGames event,
    Emitter<GamesState> emit
  ) async {
    try {
      emit(state.copyWith(phase: StatePhase.loading));

      await gameRepository.saveMany(event.games);

      emit(state.copyWith(
        phase: StatePhase.success,
      ));
    } catch (error, stacktrace) {
      print(stacktrace);
      emit(state.copyWith(phase: StatePhase.error));
    }
  }

  void _mapDeleteGameEventToState(
    DeleteGame event,
    Emitter<GamesState> emit
  ) async {
    try {
      emit(state.copyWith(phase: StatePhase.loading));

      final includedGames = state.games
        .where((game) => game.parentId == event.id);

      Future.wait(includedGames.map((e) => gameRepository.delete(e.id)));

      await gameRepository.delete(event.id);

      emit(state.copyWith(
        phase: StatePhase.success,
      ));
    } catch (error, stacktrace) {
      print(stacktrace);
      emit(state.copyWith(phase: StatePhase.error));
    }
  }

  void _mapDeleteAllGamesEventToState(
    DeleteAllGames event,
    Emitter<GamesState> emit
  ) async {
    try {
      emit(state.copyWith(phase: StatePhase.loading));

      await gameRepository.deleteAll();

      emit(state.copyWith(
        phase: StatePhase.success,
      ));
    } catch (error, stacktrace) {
      print(stacktrace);
      emit(state.copyWith(phase: StatePhase.error));
    }
  }
}