import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/models/game/game_service.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'hive_game.dart';

class HiveGameService extends GameService {
  static const boxName = 'games:v:03';

  late final Box<HiveGame> _box;

  @override
  init() async {
    Hive.registerAdapter(HiveGameAdapter());

    await Hive.initFlutter();

    _box = await Hive.openBox(boxName);

    _box.watch().listen((event) {
      notifyListeners(); 
    });
  }

  @override
  Game? get(String id ) {
    HiveGame? hiveGame = _box.get(id);

    if (hiveGame == null) {
      return null;
    }

    return hiveGame.toGame();
  }

  @override
  Iterable<Game> getAll() {
    return _box.values.map((e) => e.toGame());
  }

  @override
  Future<void> save(Game game) async {
    await _box.put(game.id, HiveGame.fromGame(game));
  }

  @override
  Future<void> delete(String id) async {
    await _box.delete(id);
  }

  @override
  Future<void> clear() async {
    await _box.clear();
  }
}