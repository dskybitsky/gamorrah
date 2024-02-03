import 'package:uuid/uuid.dart';
import 'package:hive/hive.dart';

part 'game.g.dart';

@HiveType(typeId: 1)
class Game extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String? thumbUrl;

  Game({
    required this.id,
    required this.title,
    required this.thumbUrl
  });

  factory Game.create({
    required String? title,
    required String? thumbUrl
  }) => Game(
    id: const Uuid().v4(),
    title: title ?? '', 
    thumbUrl: thumbUrl
  );
}