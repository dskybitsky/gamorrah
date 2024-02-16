import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/models/game/game_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'hive_game.dart';

class HiveGameRepository extends GameRepository {
  static const boxName = 'games:v:06';

  Box<HiveGame>? _box;

  Box<HiveGame> get box {
    if (_box == null) {
      _init();
    }

    return _box!;
  }

  @override
  Future<Iterable<Game>> get() async {
    return box.values.map((e) => e.toGame());
  }

  @override
  Future<Game?> getById(String id) async {
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
    await box.put(game.id, HiveGame.fromGame(game));
  }

  @override
  Future<void> delete(String id) async {
    await box.delete(id);
  }

  @override
  Future<void> clear() async {
    await box.clear();
  }

  _init() async {
    Hive.registerAdapter(HiveGameAdapter());

    await Hive.initFlutter();

    _box = await Hive.openBox(boxName);
  }
}