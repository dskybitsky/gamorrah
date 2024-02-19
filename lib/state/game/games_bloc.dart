import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/models/game/game_repository.dart';

part 'games_event.dart';
part 'games_state.dart';

class GamesBloc extends Bloc<GamesEvent, GamesState> {
  GamesBloc({
    required this.gameRepository,
  }) : super(const GamesState()) {
    on<LoadGames>(_mapLoadGamesEventToState);
    on<SaveGame>(_mapSaveGameEventToState);
    on<DeleteGame>(_mapDeleteGameEventToState);
  }

  final GameRepository gameRepository;

  void _mapLoadGamesEventToState(
    LoadGames event, 
    Emitter<GamesState> emit
  ) async {
    try {
      emit(state.copyWith(phase: GamesStatePhase.loading));

      final games = (await gameRepository.get());

      emit(state.copyWith(
        phase: GamesStatePhase.success,
        games: games,
      ));
    } catch (error, stacktrace) {
      print(stacktrace);
      emit(state.copyWith(phase: GamesStatePhase.error));
    }
  }

  void _mapSaveGameEventToState(
    SaveGame event,
    Emitter<GamesState> emit
  ) async {
    try {
      emit(state.copyWith(phase: GamesStatePhase.loading));

      await gameRepository.save(event.game);

      final games = state.games.map((game) {
        return game.id == event.game.id ? event.game : game;
      });

      emit(state.copyWith(
        phase: GamesStatePhase.success,
        games: games,
      ));
    } catch (error, stacktrace) {
      print(stacktrace);
      emit(state.copyWith(phase: GamesStatePhase.error));
    }
  }

  void _mapDeleteGameEventToState(
    DeleteGame event,
    Emitter<GamesState> emit
  ) async {
    try {
      emit(state.copyWith(phase: GamesStatePhase.loading));

      await gameRepository.delete(event.id);

      final games = state.games.where((game) {
        return game.id != event.id;
      });

      emit(state.copyWith(
        phase: GamesStatePhase.success,
        games: games,
      ));
    } catch (error, stacktrace) {
      print(stacktrace);
      emit(state.copyWith(phase: GamesStatePhase.error));
    }
  }
}