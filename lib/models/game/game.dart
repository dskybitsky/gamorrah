import 'package:gamorrah/models/optional.dart';
import 'package:uuid/uuid.dart';

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
    String? franchise,
    String? edition,
    int? year,
    String? thumbUrl,
    GameKind? kind,
    int? index,
    Set<GamePlatform> platforms = const {},
    GamePersonal? personal,
    GameHowLongToBeat? howLongToBeat,
    GameStatus? status,
    String? parentId,
  }) => Game(
    id: id ?? const Uuid().v4(),
    title: title, 
    franchise: _normalize(franchise),
    edition: _normalize(edition),
    year: year,
    thumbUrl: _normalize(thumbUrl),
    kind: kind,
    index: index,
    platforms: platforms,
    personal: personal,
    howLongToBeat: howLongToBeat,
    status: status ?? GameStatus.backlog,
    parentId: parentId,
  );

  factory Game.fromJson(Map<String, dynamic> data) {
    final kindName = data['kind'];
    final platformNames = data['platforms'];
    final personalJson = data['personal'];
    final howLongToBeatJson = data['howLongToBeat'];

    return Game.create(
      id: data['id'], 
      title: data['title'],
      franchise: data['franchise'],
      edition: data['edition'],
      year: data['year'],
      thumbUrl: data['thumbUrl'],
      kind: kindName != null
        ? GameKind.values.byName(kindName)
        : null,
      index: data['index'],
      platforms: Set.from(
          platformNames.map((name) => switch(name) {
            'switch' => GamePlatform.swtch,
            _ => GamePlatform.values.byName(name)
          })
      ),
      personal: personalJson != null 
        ? GamePersonal.fromJson(personalJson)
        : null,
      howLongToBeat: howLongToBeatJson != null
        ? GameHowLongToBeat.fromJson(howLongToBeatJson)
        : null,
      status: GameStatus.values.byName(data['status']),
      parentId: data['parentId'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'franchise': franchise,
    'edition': edition,
    'year': year,
    'thumbUrl': thumbUrl,
    'kind': kind?.name,
    'index': index,
    'platforms': platforms.map((e) => e.name).toList(),
    'personal': personal?.toJson(),
    'howLongToBeat': howLongToBeat?.toJson(),
    'status': status.name,
    'parentId': parentId,
  };

  Game copyWith({
    Optional<String>? title,
    Optional<String?>? franchise,
    Optional<String?>? edition,
    Optional<int?>? year,
    Optional<String?>? thumbUrl,
    Optional<GameKind?>? kind,
    Optional<int?>? index,
    Optional<Set<GamePlatform>>? platforms,
    Optional<GamePersonal?>? personal,
    Optional<GameHowLongToBeat?>? howLongToBeat,
    Optional<GameStatus?>? status,
    Optional<String?>? parentId,
  }) => Game.create(
    id: id,
    title: title != null ? title.value : this.title,
    franchise: franchise != null ? franchise.value : this.franchise,
    edition: edition != null ? edition.value : this.edition,
    year: year != null ? year.value : this.year,
    thumbUrl: thumbUrl != null ? thumbUrl.value : this.thumbUrl,
    kind: kind != null ? kind.value : this.kind,
    index: index != null ? index.value : this.index,
    platforms: platforms != null ? platforms.value : this.platforms,
    personal: personal != null ? personal.value : this.personal,
    howLongToBeat: howLongToBeat != null ? howLongToBeat.value : this.howLongToBeat,
    status: status != null ? status.value : this.status,
    parentId: parentId != null ? parentId.value : this.parentId,
  );

  static String? _normalize(String? s) => s == '' ? null : s;
}

class GamePersonal {
  GamePersonal({
    this.beaten,
    this.rating,
    this.timeSpent,
  });

  final GamePersonalBeaten? beaten;
  final double? rating;
  final double? timeSpent;

  factory GamePersonal.fromJson(Map<String, dynamic> data) {
    final beatenName = data['beaten'];
    final rating = data['rating'];
    final timeSpent = data['timeSpent'];
    
    return GamePersonal(
      beaten: beatenName != null
        ? GamePersonalBeaten.values.byName(beatenName)
        : null,
      rating: rating?.toDouble(),
      timeSpent: timeSpent?.toDouble(),
    );
  }

  GamePersonal copyWith({
    Optional<GamePersonalBeaten?>? beaten,
    Optional<double?>? rating,
    Optional<double?>? timeSpent
  }) => GamePersonal(
    beaten: beaten != null ? beaten.value : this.beaten,
    rating: rating != null ? rating.value : this.rating,
    timeSpent: timeSpent != null ? timeSpent.value : this.timeSpent,
  );

  Map<String, dynamic> toJson() => {
    'beaten': beaten?.name,
    'rating': rating,
    'timeSpent': timeSpent,
  };
}

enum GamePersonalBeaten { bronze, silver, gold, platinum }

class GameHowLongToBeat {
  GameHowLongToBeat({
    this.story,
    this.storySides,
    this.completionist
  });

  final double? story;
  final double? storySides;
  final double? completionist;

  factory GameHowLongToBeat.fromJson(Map<String, dynamic> data) {
    final story = data['story'];
    final storySides = data['storySides'];
    final completionist = data['completionist'];

    return GameHowLongToBeat(
      story: story?.toDouble(),
      storySides: storySides?.toDouble(),
      completionist: completionist?.toDouble(),
    );
  }

  GameHowLongToBeat copyWith({
    Optional<double?>? story,
    Optional<double?>? storySides,
    Optional<double?>? completionist
  }) => GameHowLongToBeat(
    story: story != null ? story.value : this.story,
    storySides: storySides != null ? storySides.value : this.storySides,
    completionist: completionist != null ? completionist.value : this.completionist,
  );

  Map<String, dynamic> toJson() => {
    'story': story,
    'storySides': storySides,
    'completionist': completionist,
  };
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