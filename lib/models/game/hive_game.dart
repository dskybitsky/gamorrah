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
  final String? franchise;

  @HiveField(3)
  final String? edition;

  @HiveField(4)
  final int? year;

  @HiveField(5)
  final String? thumbUrl;

  @HiveField(6)
  final String status;

  HiveGame({
    required this.id,
    required this.title,
    this.franchise,
    this.edition,
    this.year,
    this.thumbUrl,
    required this.status,
  });

  factory HiveGame.fromGame(Game game) => HiveGame(
    id: game.id, 
    title: game.title,
    franchise: game.franchise,
    edition: game.edition,
    year: game.year,
    thumbUrl: game.thumbUrl,
    status: game.status.name
  );

  Game toGame() => Game(
    id: id, 
    title: title, 
    franchise: franchise,
    edition: edition,
    year: year,
    thumbUrl: thumbUrl,
    status: GameStatus.values.byName(status),
  );
}