import 'package:gamorrah/models/game/game.dart';
import 'package:hive/hive.dart';

part 'hive_game.g.dart';

@HiveType(typeId: 0)
class HiveGame extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String? thumbUrl;

  @HiveField(3)
  final String status;

  HiveGame({
    required this.id,
    required this.title,
    this.thumbUrl,
    required this.status,
  });

  factory HiveGame.fromGame(Game game) => HiveGame(
    id: game.id, 
    title: game.title, 
    thumbUrl: game.thumbUrl,
    status: game.status.name
  );

  Game toGame() => Game(
    id: id, 
    title: title, 
    thumbUrl: thumbUrl,
    status: GameStatus.values.byName(status),
  );
}