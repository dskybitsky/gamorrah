import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'game.dart';

class GameService {
  static const boxName = 'games';

  final Box<Game> _box = Hive.box<Game>(boxName);

  Game? get(String id ) {
    return _box.get(id);
  }

  Iterable<Game> getAll() {
    return _box.values;
  }

  Future<void> save(Game game) async {
    await _box.put(game.id, game);
  }

  Future<void> delete(String id) async {
    await _box.delete(id);
  }

  ValueListenable<Box<Game>> listenable() {
    return _box.listenable();
  }
}