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
      kind: fields[6] as String?,
      index: fields[7] as int?,
      personalBeaten: fields[8] as String?,
      personalRating: fields[9] as double?,
      personalTimeSpent: fields[10] as int?,
      howLongToBeatStory: fields[11] as double?,
      howLongToBeatStorySides: fields[12] as double?,
      howLongToBeatCompletionist: fields[13] as double?,
      status: fields[14] as String,
      parentId: fields[15] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, HiveGame obj) {
    writer
      ..writeByte(16)
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
      ..write(obj.kind)
      ..writeByte(7)
      ..write(obj.index)
      ..writeByte(8)
      ..write(obj.personalBeaten)
      ..writeByte(9)
      ..write(obj.personalRating)
      ..writeByte(10)
      ..write(obj.personalTimeSpent)
      ..writeByte(11)
      ..write(obj.howLongToBeatStory)
      ..writeByte(12)
      ..write(obj.howLongToBeatStorySides)
      ..writeByte(13)
      ..write(obj.howLongToBeatCompletionist)
      ..writeByte(14)
      ..write(obj.status)
      ..writeByte(15)
      ..write(obj.parentId);
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
