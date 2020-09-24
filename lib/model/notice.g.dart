// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notice.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoticeAdapter extends TypeAdapter<Notice> {
  @override
  final int typeId = 0;

  @override
  Notice read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Notice(
      section: fields[2] as String,
      id: fields[0] as String,
      url: fields[5] as String,
      date: fields[4] as String,
      html: fields[7] as String,
      title: fields[1] as String,
      base: fields[8] as String,
      dateForOrder: fields[10] as int,
      summary: fields[3] as String,
      imageUrl: fields[6] as String,
    ).._textScaleFactor = fields[9] as double;
  }

  @override
  void write(BinaryWriter writer, Notice obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.section)
      ..writeByte(3)
      ..write(obj.summary)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.url)
      ..writeByte(6)
      ..write(obj.imageUrl)
      ..writeByte(7)
      ..write(obj.html)
      ..writeByte(8)
      ..write(obj.base)
      ..writeByte(9)
      ..write(obj._textScaleFactor)
      ..writeByte(10)
      ..write(obj.dateForOrder);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoticeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
