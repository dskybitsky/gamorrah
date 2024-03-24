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
      platforms: (fields[0] as List?)?.cast<String>(),
      beaten: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, HiveGamesFilter obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.platforms)
      ..writeByte(1)
      ..write(obj.beaten);
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
