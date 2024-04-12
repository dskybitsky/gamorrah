import 'package:flutter/foundation.dart';
import 'package:my_game_db/models/game/game.dart';
import 'package:my_game_db/models/optional.dart';
import 'package:uuid/uuid.dart';

class GamesView {
  GamesView({
    required this.id,
    required this.name,
    required this.status,
    this.index = 0,
    this.filter,
  });

  final String id;
  final String name;
  final GameStatus status;
  final int index;
  final GamesFilter? filter;

  factory GamesView.create({
    String? id,
    required String name,
    required GameStatus status,
    int index = 0,
    GamesFilter? filter,
  }) => GamesView(
    id: id ?? const Uuid().v4(),
    name: name, 
    status: status,
    index: index,
    filter: filter,
  );

  GamesView copyWith({
    Optional<String>? name,
    Optional<GameStatus>? status,
    Optional<int>? index,
    Optional<GamesFilter?>? filter,
  }) => GamesView.create(
    id: id,
    name: name != null ? name.value : this.name,
    status: status != null ? status.value : this.status,
    index: index != null ? index.value : this.index,
    filter: filter != null ? filter.value : this.filter,
  );
}

class GamesFilter {
  GamesFilter({
    this.platforms,
    this.beaten,
    this.howLongToBeat,
    this.tags,
  });
  
  final GamesFilterPlatformsPredicate? platforms;
  final GamesFilterBeatenPredicate? beaten;
  final GamesFilterHowLongToBeatPredicate? howLongToBeat;
  final GamesFilterTagsPredicate? tags;

  bool matches(Game game) {
    return (
      (platforms == null || platforms!.matches(game))
      && (beaten == null || beaten!.matches(game))
      && (howLongToBeat == null || howLongToBeat!.matches(game))
      && (tags == null || tags!.matches(game))
    );
  }

  bool get isEmpty => platforms == null
    && beaten == null
    && howLongToBeat == null;

  GamesFilter copyWith({
    Optional<GamesFilterPlatformsPredicate?>? platforms,
    Optional<GamesFilterBeatenPredicate?>? beaten,
    Optional<GamesFilterHowLongToBeatPredicate?>? howLongToBeat,
    Optional<GamesFilterTagsPredicate?>? tags,
  }) => GamesFilter(
    platforms: platforms != null ? platforms.value : this.platforms,
    beaten: beaten != null ? beaten.value : this.beaten,
    howLongToBeat: howLongToBeat != null ? howLongToBeat.value : this.howLongToBeat,
    tags: tags != null ? tags.value : this.tags,
  );
}

abstract class GamesFilterPredicate {
  bool matches(Game game);
}

enum GamesFilterPlatformsOperator { hasOneOf, hasNoneOf, equal }

class GamesFilterPlatformsPredicate extends GamesFilterPredicate {
  GamesFilterPlatformsPredicate({
    this.operator = GamesFilterPlatformsOperator.equal,
    this.value = const {},
  });

  final GamesFilterPlatformsOperator operator;
  final Set<GamePlatform> value;
  
  @override
  bool matches(Game game) {
    final value = game.platforms;

    switch (operator) {
      case GamesFilterPlatformsOperator.hasOneOf:
        return value.intersection(this.value).isNotEmpty;

      case GamesFilterPlatformsOperator.hasNoneOf:
        return value.intersection(this.value).isEmpty;

      case GamesFilterPlatformsOperator.equal:
        return setEquals(value, this.value);
    }
  }

  GamesFilterPlatformsPredicate copyWith({
    Optional<GamesFilterPlatformsOperator>? operator,
    Optional<Set<GamePlatform>>? value,
  }) => GamesFilterPlatformsPredicate(
    operator: operator != null ? operator.value : this.operator,
    value: value != null ? value.value : this.value,
  );
}

enum GamesFilterBeatenOperator { equal, notEqual }

class GamesFilterBeatenPredicate extends GamesFilterPredicate {
  GamesFilterBeatenPredicate({
    this.operator = GamesFilterBeatenOperator.equal,
    this.value,
  });

  final GamesFilterBeatenOperator operator;
  final GamePersonalBeaten? value;

  @override
  bool matches(Game game) {
    final value = game.personal?.beaten;

    switch (operator) {
      case GamesFilterBeatenOperator.equal:
        return value == this.value;
      
      case GamesFilterBeatenOperator.notEqual:
        return value != this.value;
    }
  }

  GamesFilterBeatenPredicate copyWith({
    Optional<GamesFilterBeatenOperator>? operator,
    Optional<GamePersonalBeaten?>? value,
  }) => GamesFilterBeatenPredicate(
    operator: operator != null ? operator.value : this.operator,
    value: value != null ? value.value : this.value,
  );
}

enum GamesFilterHowLongToBeatOperator { less, more }
enum GamesFilterHowLongToBeatField { story, storySides, completionist }

class GamesFilterHowLongToBeatPredicate extends GamesFilterPredicate {
  GamesFilterHowLongToBeatPredicate({
    this.operator = GamesFilterHowLongToBeatOperator.less,
    this.field = GamesFilterHowLongToBeatField.story,
    this.value = 60.0,
  });

  final GamesFilterHowLongToBeatOperator operator;
  final GamesFilterHowLongToBeatField field;
  final double value;

  @override
  bool matches(Game game) {
    final value = switch (field) {
      GamesFilterHowLongToBeatField.story => game.howLongToBeat?.story,
      GamesFilterHowLongToBeatField.storySides => game.howLongToBeat?.storySides,
      GamesFilterHowLongToBeatField.completionist => game.howLongToBeat?.completionist,
    };

    if (value == null) {
      return false;
    }

    switch (operator) {
      case GamesFilterHowLongToBeatOperator.less:
        return value <= this.value;
      
      case GamesFilterHowLongToBeatOperator.more:
        return value >= this.value;
    }
  }

  GamesFilterHowLongToBeatPredicate copyWith({
    Optional<GamesFilterHowLongToBeatOperator>? operator,
    Optional<GamesFilterHowLongToBeatField>? field,
    Optional<double>? value,
  }) => GamesFilterHowLongToBeatPredicate(
    operator: operator != null ? operator.value : this.operator,
    field: field != null ? field.value : this.field,
    value: value != null ? value.value : this.value,
  );
}

enum GamesFilterTagsOperator { hasOneOf, hasNoneOf, equal }

class GamesFilterTagsPredicate extends GamesFilterPredicate {
  GamesFilterTagsPredicate({
    this.operator = GamesFilterTagsOperator.equal,
    this.value = const {},
  });

  final GamesFilterTagsOperator operator;
  final Set<String> value;
  
  @override
  bool matches(Game game) {
    final value = game.tags;

    switch (operator) {
      case GamesFilterTagsOperator.hasOneOf:
        return value.intersection(this.value).isNotEmpty;

      case GamesFilterTagsOperator.hasNoneOf:
        return value.intersection(this.value).isEmpty;

      case GamesFilterTagsOperator.equal:
        return setEquals(value, this.value);
    }
  }

  GamesFilterTagsPredicate copyWith({
    Optional<GamesFilterTagsOperator>? operator,
    Optional<Set<String>>? value,
  }) => GamesFilterTagsPredicate(
    operator: operator != null ? operator.value : this.operator,
    value: value != null ? value.value : this.value,
  );
}