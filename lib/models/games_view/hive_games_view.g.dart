// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_games_view.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveGamesViewAdapter extends TypeAdapter<HiveGamesView> {
  @override
  final int typeId = 1;

  @override
  HiveGamesView read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveGamesView(
      id: fields[0] as String,
      name: fields[1] as String,
      status: fields[2] as String,
      index: fields[3] as int,
      filter: fields[4] as HiveGamesFilter?,
    );
  }

  @override
  void write(BinaryWriter writer, HiveGamesView obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.index)
      ..writeByte(4)
      ..write(obj.filter);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveGamesViewAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HiveGamesFilterAdapter extends TypeAdapter<HiveGamesFilter> {
  @override
  final int typeId = 11;

  @override
  HiveGamesFilter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveGamesFilter(
      platforms: fields[0] as HiveGamesFilterPlatformsPredicate?,
      beaten: fields[1] as HiveGamesFilterBeatenPredicate?,
      howLongToBeat: fields[2] as HiveGamesFilterHowLongToBeatPredicate?,
    );
  }

  @override
  void write(BinaryWriter writer, HiveGamesFilter obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.platforms)
      ..writeByte(1)
      ..write(obj.beaten)
      ..writeByte(2)
      ..write(obj.howLongToBeat);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveGamesFilterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HiveGamesFilterPlatformsPredicateAdapter
    extends TypeAdapter<HiveGamesFilterPlatformsPredicate> {
  @override
  final int typeId = 12;

  @override
  HiveGamesFilterPlatformsPredicate read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveGamesFilterPlatformsPredicate(
      operator: fields[0] as String,
      value: (fields[1] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, HiveGamesFilterPlatformsPredicate obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.operator)
      ..writeByte(1)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveGamesFilterPlatformsPredicateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HiveGamesFilterBeatenPredicateAdapter
    extends TypeAdapter<HiveGamesFilterBeatenPredicate> {
  @override
  final int typeId = 13;

  @override
  HiveGamesFilterBeatenPredicate read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveGamesFilterBeatenPredicate(
      operator: fields[0] as String,
      value: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, HiveGamesFilterBeatenPredicate obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.operator)
      ..writeByte(1)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveGamesFilterBeatenPredicateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HiveGamesFilterHowLongToBeatPredicateAdapter
    extends TypeAdapter<HiveGamesFilterHowLongToBeatPredicate> {
  @override
  final int typeId = 15;

  @override
  HiveGamesFilterHowLongToBeatPredicate read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveGamesFilterHowLongToBeatPredicate(
      operator: fields[0] as String,
      field: fields[1] as String,
      value: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, HiveGamesFilterHowLongToBeatPredicate obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.operator)
      ..writeByte(1)
      ..write(obj.field)
      ..writeByte(2)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveGamesFilterHowLongToBeatPredicateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
