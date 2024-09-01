import 'package:hive/hive.dart';

part 'prediction_data.g.dart';

@HiveType(typeId: 0)
class PredictionData extends HiveObject {
  @HiveField(0)
  String? prediction;

  @HiveField(1)
  DateTime? dateTime;

  @HiveField(2)
  String? imageName;

  

  @HiveField(3, defaultValue: <String>[])
  List<String>? chat;

  PredictionData({this.prediction, this.dateTime, this.imageName, this.chat});
}
