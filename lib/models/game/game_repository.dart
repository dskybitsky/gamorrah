import 'package:gamorrah/models/game/game.dart';

abstract class GameRepository {
  Future<Iterable<Game>> get();

  Future<Game?> getById(String id);

  Future<Iterable<Game>> getByStatus(GameStatus status);

  Future<void> save(Game game);

  Future<void> delete(String id);

  Future<void> clear();
}