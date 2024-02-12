import 'package:flutter/material.dart';
import 'package:gamorrah/models/game/game.dart';

abstract class GameService extends ChangeNotifier {
  Future<void> init();

  Game? get(String id );

  Iterable<Game> getAll();

  Iterable<Game> getMainList(GameStatus status);

  Iterable<Game> getIncludedList(String id);

  Future<void> reorderIncluded(String id, int oldIndex, int newIndex);

  Future<void> save(Game game);

  Future<void> delete(String id);

  Future<void> clear();

  Future<void> importJson(String json);
}