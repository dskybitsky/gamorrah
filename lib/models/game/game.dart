import 'package:uuid/uuid.dart';
import 'package:hive/hive.dart';

enum GameStatus { backlog, playing, finished, wishlist }

class Game extends HiveObject {
  final String id;

  final String title;

  final String? thumbUrl;

  final GameStatus status;

  Game({
    required this.id,
    required this.title,
    this.thumbUrl,
    required this.status,
  });

  factory Game.create({
    String? id,
    required String title,
    String? thumbUrl,
    GameStatus? status,
  }) => Game(
    id: id ?? const Uuid().v4(),
    title: title, 
    thumbUrl: thumbUrl,
    status: status ?? GameStatus.backlog,
  );

  Game copyWith({
    String? title,
    String? thumbUrl,
    GameStatus? status,
  }) => Game(
    id: id,
    title: title ?? this.title,
    thumbUrl: thumbUrl ?? this.thumbUrl,
    status: status ?? this.status,
  );
}