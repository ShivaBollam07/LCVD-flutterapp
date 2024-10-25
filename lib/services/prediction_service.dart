import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:lcvd/api/vision.dart';
import 'package:lcvd/models/prediction.dart';
import 'package:path/path.dart' as path;

class PredictionService {
  static const String boxName = "predictionBox";
  static Box<Prediction> box = Hive.box<Prediction>(boxName);

  static Box<Prediction> getPredictionBox() {
    return box;
  }

  static getKey(Prediction prediction) {
    return prediction.dateTime.toIso8601String().substring(0, 23);
  }

  static ValueListenable<Box<Prediction>> getListenable() {
    return box.listenable();
  }

  static Future<void> addPrediction(Prediction prediction) async {
    await box.put(getKey(prediction), prediction);
  }

  static Future<void> updatePrediction(Prediction prediction) async {
    await box.put(getKey(prediction), prediction);
  }

  static Future<void> deletePrediction(Prediction prediction) async {
    await deletePredictionImage(prediction);
    await box.delete(getKey(prediction));
  }

  static Future<File?> loadImageFile(Prediction prediction) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath =
          path.join(directory.path, 'images', prediction.imageName);
      return File(filePath);
    } catch (e) {
      print('Error loading image: $e');
      return null;
    }
  }

  static Future<void> deletePredictionImage(Prediction prediction) async {
    File? file = await loadImageFile(prediction);
    if (file == null) {
      return;
    }
    try {
      await file.delete();
    } catch (e) {
      print('Error deleting image: $e');
    }
  }

  static Future<bool> getPrediction(Prediction prediction) async {
    if (prediction.predicted) {
      return true;
    }

    File? imageFile = await loadImageFile(prediction);

    if (imageFile == null) {
      return false;
    }

    String? output = await getVisionPrediction(imageFile);

    Prediction updatedPrediction = Prediction(
        dateTime: prediction.dateTime,
        imageName: prediction.imageName,
        caseName: prediction.caseName,
        chat: prediction.chat,
        prediction: output,
        predicted: true);

    await updatePrediction(updatedPrediction);

    return true;
  }
}
