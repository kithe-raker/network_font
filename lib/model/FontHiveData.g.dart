// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FontHiveData.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FontHiveDataAdapter extends TypeAdapter<FontHiveData> {
  @override
  final int typeId = 0;

  @override
  FontHiveData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FontHiveData()
      ..family = fields[0] as String
      ..url = fields[1] as String
      ..initedTimestamp = fields[2] as int;
  }

  @override
  void write(BinaryWriter writer, FontHiveData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.family)
      ..writeByte(1)
      ..write(obj.url)
      ..writeByte(2)
      ..write(obj.initedTimestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FontHiveDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
