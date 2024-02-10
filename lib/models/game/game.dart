import 'package:uuid/uuid.dart';

enum GamePersonalBeaten { story, storySides, completionist }

class GamePersonal {
  GamePersonal({
    this.beaten,
    this.rating,
    this.timeSpent,
  });

  final GamePersonalBeaten? beaten;
  final double? rating;
  final int? timeSpent;
}

class GameHowLongToBeat {
  GameHowLongToBeat({
    this.story,
    this.storySides,
    this.completionist
  });

  final double? story;
  final double? storySides;
  final double? completionist;
}

enum GameKind { bundle, dlc, content }

enum GameStatus { backlog, playing, finished, wishlist }

class Game {
  Game({
    required this.id,
    required this.title,
    this.franchise,
    this.edition,
    this.year,
    this.thumbUrl,
    this.kind,
    this.index,
    this.personal,
    this.howLongToBeat,
    required this.status,
    this.parentId,
  });

  final String id;

  final String title;
  final String? franchise;
  final String? edition;
  final int? year;
  final String? thumbUrl;

  final GameKind? kind;
  final int? index;

  final GamePersonal? personal;
  final GameHowLongToBeat? howLongToBeat;

  final GameStatus status;

  final String? parentId;

  factory Game.create({
    String? id,
    required String title,
    String? thumbUrl,
    GameStatus? status,
    String? parentId,
  }) => Game(
    id: id ?? const Uuid().v4(),
    title: title, 
    thumbUrl: thumbUrl,
    status: status ?? GameStatus.backlog,
    parentId: parentId,
  );

  Game copyWith({
    String? title,
    String? franchise,
    String? edition,
    int? year,
    String? thumbUrl,
    GameKind? kind,
    int? index,
    GamePersonal? personal,
    GameHowLongToBeat? howLongToBeat,
    GameStatus? status,
    String? parentId,
  }) => Game(
    id: id,
    title: title ?? this.title,
    franchise: franchise ?? this.franchise,
    edition: edition ?? this.edition,
    year: year ?? this.year,
    thumbUrl: thumbUrl ?? this.thumbUrl,
    kind: kind ?? this.kind,
    index: index ?? this.index,
    personal: personal ?? this.personal,
    howLongToBeat: howLongToBeat ?? this.howLongToBeat,
    status: status ?? this.status,
    parentId: parentId ?? this.parentId,
  );

  GamePersonal? copyPersonalWith({
    GamePersonalBeaten? beaten,
    double? rating,
    int? timeSpent
  }) => beaten != null || rating != null || timeSpent != null
    ? GamePersonal(
      beaten: beaten ?? personal?.beaten,
      rating: rating ?? personal?.rating,
      timeSpent: timeSpent ?? personal?.timeSpent,
    ): personal;
  
  GameHowLongToBeat? copyHowLongToBeatWith({
    double? story,
    double? storySides,
    double? completionist
  }) => story != null || storySides != null || completionist != null
    ? GameHowLongToBeat(
      story: story ?? howLongToBeat?.story,
      storySides: storySides ?? howLongToBeat?.storySides,
      completionist: completionist ?? howLongToBeat?.completionist,
    ): howLongToBeat;
}