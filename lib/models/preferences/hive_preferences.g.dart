// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_preferences.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HivePreferencesAdapter extends TypeAdapter<HivePreferences> {
  @override
  final int typeId = 200;

  @override
  HivePreferences read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HivePreferences(
      dataDir: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, HivePreferences obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.dataDir);
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
