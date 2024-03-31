import 'package:gamorrah/models/game/game.dart';

abstract class GameRepository {
  Future<Iterable<Game>> get();

  Future<Game?> getById(String id);

  Future<void> save(Game game);

  Future<void> saveMany(Iterable<Game> games);

  Future<void> delete(String id);

  Future<void> deleteAll();
}