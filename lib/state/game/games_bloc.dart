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
    on<GetGames>(_mapGetGamesEventToState);
    on<SaveGame>(_mapSaveGameEventToState);
  }

  final GameRepository gameRepository;

  void _mapGetGamesEventToState(
    GetGames event, 
    Emitter<GamesState> emit
  ) async {
    try {
      emit(state.copyWith(phase: GamesStatePhase.loading));

      final games = (await gameRepository.getByStatus(event.status))
        .where((game) => game.parentId == null)
        .toList();
    
      games.sort(_gamesComparator);
      
      emit(
        state.copyWith(
          phase: GamesStatePhase.success,
          games: games,
          status: event.status,
        ),
      );
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

      emit(state.copyWith(phase: GamesStatePhase.success));
    } catch (error, stacktrace) {
      print(stacktrace);
      emit(state.copyWith(phase: GamesStatePhase.error));
    }
  }

  int _gamesComparator(Game gameA, Game gameB) {
    final franchisedTitleA = gameA.franchise ?? gameA.title;
    final franchisedTitleB = gameB.franchise ?? gameB.title;
            
    if (franchisedTitleA == franchisedTitleB) {
      final franchisedIndexA = gameA.index ?? gameA.year ?? 0;
      final franchisedIndexB = gameB.index ?? gameB.year ?? 0;
                
      return franchisedIndexA.compareTo(franchisedIndexB);
    }
            
    return franchisedTitleA.compareTo(franchisedTitleB);
  }
}