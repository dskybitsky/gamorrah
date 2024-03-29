import 'package:gamorrah/models/games_view/games_view.dart';

abstract class GamesViewRepository {
  Future<Iterable<GamesView>> get();

  Future<void> save(GamesView gamesView);

  Future<void> delete(String id);
}