import 'package:gamorrah/conf.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/models/game/game_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'hive_game.dart';

class HiveGameRepository extends GameRepository {
  static const boxName = EnvironmentConfig.isDev 
    ? 'games:v:08:dev'
    : 'games:v:08';

  Box<HiveGame>? _box;

  @override
  Future<Iterable<Game>> get() async {
    final box = await _getBox();

    return box.values.map((e) => e.toGame());
  }

  @override
  Future<Game?> getById(String id) async {
    final box = await _getBox();

    HiveGame? hiveGame = box.get(id);

    if (hiveGame == null) {
      return null;
    }

    return hiveGame.toGame();
  }

  @override
  Future<Iterable<Game>> getByStatus(GameStatus status) async {
    final games = await get();

    return games.where((element) => element.status == status);
  }

  @override
  Future<void> save(Game game) async {
    await saveMany([game]);
  }

  @override
  Future<void> saveMany(Iterable<Game> games) async {
    final box = await _getBox();

    Future.wait(
      games.map((game) => box.put(game.id, HiveGame.fromGame(game)))
    );
  }

  @override
  Future<void> delete(String id) async {
    final box = await _getBox();

    await box.delete(id);
  }

  @override
  Future<void> deleteAll() async {
    final box = await _getBox();
    
    await box.clear();
  }

  Future<Box<HiveGame>> _getBox() async {
    if (_box == null) {
      await _init();
    }

    return _box!;
  }

  _init() async {
    _box = await Hive.openBox(boxName);
  }
}