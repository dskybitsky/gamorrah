// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_game.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveGameAdapter extends TypeAdapter<HiveGame> {
  @override
  final int typeId = 0;

  @override
  HiveGame read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveGame(
      id: fields[0] as String,
      title: fields[1] as String,
      franchise: fields[2] as String?,
      edition: fields[3] as String?,
      year: fields[4] as int?,
      thumbUrl: fields[5] as String?,
      status: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveGame obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.franchise)
      ..writeByte(3)
      ..write(obj.edition)
      ..writeByte(4)
      ..write(obj.year)
      ..writeByte(5)
      ..write(obj.thumbUrl)
      ..writeByte(6)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveGameAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
