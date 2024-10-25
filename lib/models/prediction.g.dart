// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prediction.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PredictionAdapter extends TypeAdapter<Prediction> {
  @override
  final int typeId = 0;

  @override
  Prediction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Prediction(
      prediction: fields[2] as String?,
      dateTime: fields[0] as DateTime,
      imageName: fields[1] as String,
      caseName: fields[3] as String?,
      predicted: fields[5] == null ? false : fields[5] as bool,
      error: fields[6] == null ? false : fields[6] as bool,
      chat: fields[4] == null ? [] : (fields[4] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Prediction obj) {
    writer
      ..writeByte(7)
      ..writeByte(1)
      ..write(obj.imageName)
      ..writeByte(0)
      ..write(obj.dateTime)
      ..writeByte(2)
      ..write(obj.prediction)
      ..writeByte(3)
      ..write(obj.caseName)
      ..writeByte(4)
      ..write(obj.chat)
      ..writeByte(5)
      ..write(obj.predicted)
      ..writeByte(6)
      ..write(obj.error);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PredictionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
