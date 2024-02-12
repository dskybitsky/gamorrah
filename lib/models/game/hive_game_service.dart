import 'dart:convert';

import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/models/game/game_service.dart';
import 'package:gamorrah/models/optional.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'hive_game.dart';

class HiveGameService extends GameService {
  static const boxName = 'games:v:06';

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
  Iterable<Game> getMainList(GameStatus status) {
    var games = getAll()
      .where((game) => game.status == status && game.parentId == null)
      .toList();
    
    games
      .sort((gameA, gameB) {
        final franchisedTitleA = gameA.franchise ?? gameA.title;
        final franchisedTitleB = gameB.franchise ?? gameB.title;
                
        if (franchisedTitleA == franchisedTitleB) {
          final franchisedIndexA = gameA.index ?? gameA.year ?? 0;
          final franchisedIndexB = gameB.index ?? gameB.year ?? 0;
                    
          return franchisedIndexA.compareTo(franchisedIndexB);
        }
                
        return franchisedTitleA.compareTo(franchisedTitleB);
      });

    return games;
  }

  @override
  Iterable<Game> getIncludedList(String id) {
    var games = getAll()
      .where((nestedGame) => nestedGame.parentId == id)
      .toList();

    games
      .sort((gameA, gameB) => (gameA.index ?? 0).compareTo(gameB.index ?? 0));

    return games;
  }

  @override
  Future<void> reorderIncluded(String id, int oldIndex, int newIndex) async {
    var games = getIncludedList(id).toList();

    final movingGame = games.removeAt(oldIndex);

    games.insert(newIndex, movingGame);

    for (final (index, includedGame) in games.indexed) {
      await save(includedGame.copyWith(index: Optional(index)));
    }
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
  Future<void> importJson(String json) async {
    await clear();

    final data = jsonDecode(json);

    for (var item in data['games']) {
      Game game = Game.fromJson(item);

      await save(game);
    }
  }

  @override
  String exportJson() {
    final games = getAll().toList();

    games.sort((gameA, gameB) => gameA.title.compareTo(gameB.title));

    final data = { 
      'games': games.map((e) => e.toJson()).toList(),
    };

    return jsonEncode(data);
  }

  @override
  Future<void> clear() async {
    await _box.clear();
  }
}