import 'package:flutter/foundation.dart';
import 'package:gamorrah/models/games_view/games_view.dart';
import 'package:gamorrah/models/games_view/games_view_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'hive_games_view.dart';

class HiveGamesViewRepository extends GamesViewRepository {
  static const boxName = kDebugMode
    ? 'games-view:v:01:debug'
    : 'games-view:v:01';

  Box<HiveGamesView>? _box;

  @override
  Future<Iterable<GamesView>> get() async {
    final box = await _getBox();
    
    return box.values.map((e) => e.toGamesView());
  }

  @override
  Future<void> save(GamesView gamesView) async {
    final box = await _getBox();

    await box.put(0, HiveGamesView.fromGamesView(gamesView));
  }

  @override
  Future<void> delete(String id) async {
    final box = await _getBox();

    await box.delete(id);
  }

  Future<Box<HiveGamesView>> _getBox() async {
    if (_box == null) {
      await _init();
    }

    return _box!;
  }

  _init() async {
    _box = await Hive.openBox(boxName);
  }
}