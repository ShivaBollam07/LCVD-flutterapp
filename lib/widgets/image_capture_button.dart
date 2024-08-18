import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lcdvd/api/predict.dart';
import 'package:lcdvd/models/prediction_data.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;

class ImagePickerButton extends StatefulWidget {
  const ImagePickerButton({super.key});

  @override
  ImagePickerButtonState createState() => ImagePickerButtonState();
}

class ImagePickerButtonState extends State<ImagePickerButton> {
  Box<PredictionData>? predictionBox;

  @override
  void initState() {
    super.initState();
    predictionBox = Hive.box<PredictionData>('predictionBox');
  }

  void _addPrediction(PredictionData data) {
    predictionBox?.add(data);
  }

  Future<void> _requestPermissions() async {
    // Request camera permission
    if (await Permission.camera.request().isDenied) {
      // If permission is permanently denied, show an alert
      if (await Permission.camera.isPermanentlyDenied) {
        openAppSettings();
      }
      return;
    }

    // Request storage permission (for Android)
    if (await Permission.storage.request().isDenied) {
      if (await Permission.storage.isPermanentlyDenied) {
        openAppSettings();
      }
      return;
    }
  }

  Future<void> _pickImageAndSave() async {
    final picker = ImagePicker();

    // Show dialog to choose between camera and gallery
    final source = await showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Image Source'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, ImageSource.camera),
            child: const Text('Camera'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, ImageSource.gallery),
            child: const Text('Gallery'),
          ),
        ],
      ),
    );

    if (source != null) {
      // Pick the image
      final pickedFile = await picker.pickImage(source: source);

      if (pickedFile != null) {
        // Get the application's document directory
        final directory = await getApplicationDocumentsDirectory();
        final imagesDir = Directory(path.join(directory.path, 'images'));

        // Create the images directory if it doesn't exist
        if (!imagesDir.existsSync()) {
          imagesDir.createSync(recursive: true);
        }

        // Copy the picked image to the application's document directory
        final fileName = path.basename(pickedFile.path);

        final savedImage = await File(pickedFile.path)
            .copy(path.join(imagesDir.path, fileName));

        // await Future.delayed(const Duration(seconds: 3));
        PredictionData? predictionData = await uploadFile(
            savedImage, "https://lcda-backend.onrender.com/predict");
        if (predictionData != null) {
          _addPrediction(predictionData);

          if (mounted) {
            // Only use context if the widget is still mounted
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Image saved: ${savedImage.path}')),
            );
          }
        }else{
          await savedImage.delete();
          if (mounted) {
            // Only use context if the widget is still mounted
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('An error occured')),
            );
          }

        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        // Request permission to access the camera and storage
        await _requestPermissions();

        // Open the image picker
        await _pickImageAndSave();
      },
      tooltip: 'Pick Image',
      child: const Icon(Icons.camera_alt),
    );
  }
}
