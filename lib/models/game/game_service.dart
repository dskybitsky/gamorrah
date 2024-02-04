import 'package:flutter/material.dart';
import 'package:gamorrah/models/game/game.dart';

abstract class GameService extends ChangeNotifier {
  Future<void> init();

  Game? get(String id );

  Iterable<Game> getAll();

  Future<void> save(Game game);

  Future<void> delete(String id);

  Future<void> clear();
}