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

enum GamePlatform {
  pc(title: 'PC/Mac'),
  
  mobile(title: 'Mobile'),
  
  megadrive(title: 'Sega MegaDrive'), 
  saturn(title: 'Sega Saturn'), 
  dreamcast(title: 'Sega Dreamcast'),
  
  nes(title: 'Nintendo NES'),
  snes(title: 'Nintendo SNES'),
  gamecube(title: 'Nintendo GameCube'),
  wii(title: 'Nintendo Wii'),
  wiiu(title: 'Nintendo Wii U'), 
  swtch(title: 'Nintendo Switch'), 
  gb(title: 'Nintedo GameBoy'), 
  gba(title: 'Nintendo GameBoy Advance'), 
  ds(title: 'Nintendo DS'), 
  ds3(title: 'Nintendo 3DS'),

  ps(title: 'Sony PlayStation'),
  ps2(title: 'Sony PlayStation 2'), 
  ps3(title: 'Sony PlayStation 3'), 
  ps4(title: 'Sony PlayStation 4/Pro'), 
  ps5(title: 'Sony PlayStation 5'), 
  psp(title: 'Sony PSP'),
  psvita(title: 'Sony PS Vita'),
  
  xbox(title: 'Microsoft XBox'), 
  xbox360(title: 'Microsoft XBox 360'), 
  xboxone(title: 'Microsoft XBox One'), 
  xboxseries(title: 'Microsoft XBox Series S/X');

  const GamePlatform({
    required this.title
  });

  final String title;
}

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
    this.platforms = const {},
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

  final Set<GamePlatform> platforms;
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
    Set<GamePlatform>? platforms,
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
    platforms: platforms ?? this.platforms,
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