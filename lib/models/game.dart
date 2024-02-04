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
    this.thumbUrl
  });

  factory Game.create({
    String? id,
    required String title,
    String? thumbUrl
  }) => Game(
    id: id ?? const Uuid().v4(),
    title: title, 
    thumbUrl: thumbUrl
  );

  Game copyWith({
    String? title,
    String? thumbUrl
  }) => Game(
    id: id,
    title: title ?? this.title,
    thumbUrl: thumbUrl ?? this.thumbUrl,
  );
}