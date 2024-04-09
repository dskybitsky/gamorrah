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
    this.tags = const {},
    this.parentId,
  });

  final String id;

  final String title;
  final String? franchise;
  final int? year;
  final String? edition;
  final String? thumbUrl;

  final GameKind? kind;
  final int? index;

  final Set<GamePlatform> platforms;
  final GamePersonal? personal;
  final GameHowLongToBeat? howLongToBeat;

  final Set<String> tags;

  final GameStatus status;
  
  final String? parentId;

  factory Game.create({
    String? id,
    required String title,
    String? franchise,
    int? year,
    String? edition,
    String? thumbUrl,
    GameKind? kind,
    int? index,
    Set<GamePlatform> platforms = const {},
    GamePersonal? personal,
    GameHowLongToBeat? howLongToBeat,
    Set<String> tags = const {},
    GameStatus? status,
    String? parentId,
  }) => Game(
    id: id ?? const Uuid().v4(),
    title: title, 
    franchise: _normalize(franchise),
    year: year,
    edition: _normalize(edition),
    thumbUrl: _normalize(thumbUrl),
    kind: kind,
    index: index,
    platforms: platforms,
    personal: personal,
    howLongToBeat: howLongToBeat,
    tags: tags
      .map((tag) => tag.toLowerCase())
      .where((tag) => tag != '')
      .toSet(),
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
      year: data['year'],
      edition: data['edition'],
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
      tags: data['tags'] ?? {},
      status: GameStatus.values.byName(data['status']),
      parentId: data['parentId'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'franchise': franchise,
    'year': year,
    'edition': edition,
    'thumbUrl': thumbUrl,
    'kind': kind?.name,
    'index': index,
    'platforms': platforms.map((e) => e.name).toList(),
    'personal': personal?.toJson(),
    'howLongToBeat': howLongToBeat?.toJson(),
    'tags': tags,
    'status': status.name,
    'parentId': parentId,
  };

  Game copyWith({
    Optional<String>? title,
    Optional<String?>? franchise,
    Optional<int?>? year,
    Optional<String?>? edition,
    Optional<String?>? thumbUrl,
    Optional<GameKind?>? kind,
    Optional<int?>? index,
    Optional<Set<GamePlatform>>? platforms,
    Optional<GamePersonal?>? personal,
    Optional<GameHowLongToBeat?>? howLongToBeat,
    Optional<Set<String>>? tags,
    Optional<GameStatus?>? status,
    Optional<String?>? parentId,
  }) => Game.create(
    id: id,
    title: title != null ? title.value : this.title,
    franchise: franchise != null ? franchise.value : this.franchise,
    year: year != null ? year.value : this.year,
    edition: edition != null ? edition.value : this.edition,
    thumbUrl: thumbUrl != null ? thumbUrl.value : this.thumbUrl,
    kind: kind != null ? kind.value : this.kind,
    index: index != null ? index.value : this.index,
    platforms: platforms != null ? platforms.value : this.platforms,
    personal: personal != null ? personal.value : this.personal,
    howLongToBeat: howLongToBeat != null ? howLongToBeat.value : this.howLongToBeat,
    tags: tags != null ? tags.value : this.tags,
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
  pc,
  mobile,
  
  megadrive(brand: GamePlatformBrand.sega, generation: 4),
  saturn(brand: GamePlatformBrand.sega, generation: 5),
  dreamcast(brand: GamePlatformBrand.sega, generation: 6),
  
  nes(brand: GamePlatformBrand.nintendo, generation: 3),
  snes(brand: GamePlatformBrand.nintendo, generation: 4),
  n64(brand: GamePlatformBrand.nintendo, generation: 5),
  gamecube(brand: GamePlatformBrand.nintendo, generation: 6),
  wii(brand: GamePlatformBrand.nintendo, generation: 7),
  wiiu(brand: GamePlatformBrand.nintendo, generation: 8),
  swtch(brand: GamePlatformBrand.nintendo, generation: 8),
  gb(brand: GamePlatformBrand.nintendo, generation: 4),
  gba(brand: GamePlatformBrand.nintendo, generation: 6),
  ds(brand: GamePlatformBrand.nintendo, generation: 7),
  ds3(brand: GamePlatformBrand.nintendo, generation: 8),

  ps(brand: GamePlatformBrand.sony, generation: 5),
  ps2(brand: GamePlatformBrand.sony, generation: 6),
  ps3(brand: GamePlatformBrand.sony, generation: 7),
  ps4(brand: GamePlatformBrand.sony, generation: 8),
  ps5(brand: GamePlatformBrand.sony, generation: 9),
  psp(brand: GamePlatformBrand.sony, generation: 7),
  psvita(brand: GamePlatformBrand.sony, generation: 8),
  
  xbox(brand: GamePlatformBrand.microsoft, generation: 6),
  xbox360(brand: GamePlatformBrand.microsoft, generation: 7),
  xboxone(brand: GamePlatformBrand.microsoft, generation: 8),
  xboxseries(brand: GamePlatformBrand.microsoft, generation: 9);

  const GamePlatform({
    this.brand,
    this.generation,
  });

  final int? generation;
  final GamePlatformBrand? brand;
}

enum GamePlatformBrand { sega, nintendo, sony, microsoft }