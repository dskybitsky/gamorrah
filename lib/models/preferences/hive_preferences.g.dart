// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_preferences.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HivePreferencesAdapter extends TypeAdapter<HivePreferences> {
  @override
  final int typeId = 1;

  @override
  HivePreferences read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HivePreferences(
      gamesPresets: (fields[0] as List).cast<HiveGamesPreset>(),
    );
  }

  @override
  void write(BinaryWriter writer, HivePreferences obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.gamesPresets);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HivePreferencesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HiveGamesPresetAdapter extends TypeAdapter<HiveGamesPreset> {
  @override
  final int typeId = 11;

  @override
  HiveGamesPreset read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveGamesPreset(
      name: fields[0] as String,
      status: fields[1] as String,
      filter: fields[2] as HiveGamesFilter?,
    );
  }

  @override
  void write(BinaryWriter writer, HiveGamesPreset obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.status)
      ..writeByte(2)
      ..write(obj.filter);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveGamesPresetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HiveGamesFilterAdapter extends TypeAdapter<HiveGamesFilter> {
  @override
  final int typeId = 12;

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
