import 'package:gamorrah/models/game/game.dart';
import 'package:hive/hive.dart';

part 'hive_game.g.dart';

@HiveType(typeId: 0)
class HiveGame extends HiveObject {
  HiveGame({
    required this.id,
    required this.title,
    this.franchise,
    this.edition,
    this.year,
    this.thumbUrl,
    this.kind,
    this.index,
    this.platforms = const [],
    this.personalBeaten,
    this.personalRating,
    this.personalTimeSpent,
    this.howLongToBeatStory,
    this.howLongToBeatStorySides,
    this.howLongToBeatCompletionist,
    required this.status,
    this.parentId,
  });

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
  final String? kind;

  @HiveField(7)
  final int? index;

  @HiveField(8)
  final List<String> platforms;

  @HiveField(9)
  final String? personalBeaten;

  @HiveField(10)
  final double? personalRating;

  @HiveField(11)
  final double? personalTimeSpent;

  @HiveField(12)
  final double? howLongToBeatStory;

  @HiveField(13)
  final double? howLongToBeatStorySides;

  @HiveField(14)
  final double? howLongToBeatCompletionist;

  @HiveField(15)
  final String status;

  @HiveField(16)
  final String? parentId;

  factory HiveGame.fromGame(Game game) => HiveGame(
    id: game.id, 
    title: game.title,
    franchise: game.franchise,
    edition: game.edition,
    year: game.year,
    thumbUrl: game.thumbUrl,
    kind: game.kind?.name,
    index: game.index,
    platforms: game.platforms.map((platform) => platform.name).toList(),
    personalBeaten: game.personal?.beaten?.name,
    personalRating: game.personal?.rating,
    personalTimeSpent: game.personal?.timeSpent,
    howLongToBeatStory: game.howLongToBeat?.story,
    howLongToBeatStorySides: game.howLongToBeat?.storySides,
    howLongToBeatCompletionist: game.howLongToBeat?.completionist,
    status: game.status.name,
    parentId: game.parentId,
  );

  Game toGame() => Game(
    id: id, 
    title: title, 
    franchise: franchise,
    edition: edition,
    year: year,
    thumbUrl: thumbUrl,
    kind: kind != null ? GameKind.values.byName(kind!) : null,
    index: index,
    platforms: Set.from( 
      platforms.map((platformName) => GamePlatform.values.byName(platformName))
    ),
    personal: _toGamePersonal(),
    howLongToBeat: _toGameHowLongToBeat(),
    status: GameStatus.values.byName(status),
    parentId: parentId,
  );

  GamePersonal? _toGamePersonal() => _hasPersonal() ? GamePersonal(
    beaten: personalBeaten != null
      ? GamePersonalBeaten.values.byName(personalBeaten!)
      : null,
    rating: personalRating,
    timeSpent: personalTimeSpent,
  ) : null;

  GameHowLongToBeat? _toGameHowLongToBeat() => _hasHowLongToBeat() ? GameHowLongToBeat(
    story: howLongToBeatStory,
    storySides: howLongToBeatStorySides,
    completionist: howLongToBeatCompletionist,
  ) : null;

  bool _hasPersonal() => personalBeaten != null || personalRating != null || personalTimeSpent != null;

  bool _hasHowLongToBeat() => howLongToBeatStory != null
    || howLongToBeatStorySides != null
    || howLongToBeatCompletionist != null;
}