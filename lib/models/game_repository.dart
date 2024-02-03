import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'game.dart';

class GameRepository {
  static const boxName = 'gameBox';

  final Box<Game> box = Hive.box<Game>(boxName);

  Future<Game?> getGame({ required String id }) async {
    return box.get(id);
  }

  Future<void> addGame({ required Game game }) async {
    await box.put(game.id, game);
  }

  Future<void> updateGame({ required Game game }) async {
    await game.save();
  }

  Future<void> deleteGame({ required Game game }) async {
    await game.delete();
  }

  ValueListenable<Box<Game>> listenToGames() {
    return box.listenable();
  }
}