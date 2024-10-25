import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;
import 'package:image/image.dart' as img;
import 'package:lcvd/models/prediction.dart';
import 'package:lcvd/services/prediction_service.dart';

class AddImageFAB extends StatefulWidget {
  const AddImageFAB({super.key});

  @override
  State<AddImageFAB> createState() => _AddImageFABState();
}

class _AddImageFABState extends State<AddImageFAB> {
  final _picker = ImagePicker();
  final _cropper = ImageCropper();

  Future<void> _requestPermissions() async {
    if (await Permission.camera.request().isDenied) {
      if (await Permission.camera.isPermanentlyDenied) {
        openAppSettings();
      }
      return;
    }

    if (await Permission.storage.request().isDenied) {
      if (await Permission.storage.isPermanentlyDenied) {
        openAppSettings();
      }
      return;
    }
  }

  Future<XFile?> _pickImage(ImageSource? imageSource) async {
    await _requestPermissions();

    if (imageSource == null) {
      return null;
    }

    XFile? image = await _picker.pickImage(source: imageSource);

    return image;
  }

  Future<String?> _resizeAndSaveImage(CroppedFile? croppedFile) async {
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    final Directory imagesDir =
        Directory(path.join(appDocumentsDir.path, 'images'));

    if (!imagesDir.existsSync()) {
      imagesDir.createSync(recursive: true);
    }

    String? savedImagePath;

    if (croppedFile != null) {
      final imageName = path.basename(croppedFile.path);
      final imageBytes = await croppedFile.readAsBytes();
      img.Image? decodedImage = img.decodeImage(imageBytes);
      if (decodedImage != null) {
        img.Image resizedImage = img.copyResize(
          decodedImage,
          width: 100,
          height: 100,
        );

        // Encode the resized image back to a file
        final resizedImageFile = File(croppedFile.path)
          ..writeAsBytesSync(img.encodeJpg(resizedImage));

        // Save the resized image to the desired location
        final savedImage =
            await resizedImageFile.copy(path.join(imagesDir.path, imageName));

        savedImagePath = savedImage.path;
      }
    }

    return savedImagePath;
  }

  Future<CroppedFile?> _cropImage(XFile imageFile) async {
    CroppedFile? croppedFile = await _cropper.cropImage(
      sourcePath: imageFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop into the leaf',
          hideBottomControls: true,
        ),
        IOSUiSettings(
          title: 'Crop into the leaf',
        ),
        WebUiSettings(
          rotatable: false,
          context: context,
        ),
      ],
    );

    return croppedFile;
  }

  Future<ImageSource?> _getImageSource() async {
    final source = await showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Image Source'),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () => Navigator.pop(context, ImageSource.camera),
            child: const Text('Camera'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, ImageSource.gallery),
            child: const Text('Gallery'),
          ),
        ],
      ),
    );
    return source;
  }

  void _handleAddImage() async {
    await _requestPermissions();

    ImageSource? imageSource = await _getImageSource();

    XFile? pickedImage = await _pickImage(imageSource);

    if (pickedImage == null) {
      return;
    }

    CroppedFile? croppedImage = await _cropImage(pickedImage);
    String? finalImagePath = await _resizeAndSaveImage(croppedImage);

    if (finalImagePath == null) {
      return;
    }

    print(finalImagePath);

    Prediction prediction = Prediction(
        dateTime: DateTime.now(), imageName: path.basename(finalImagePath));
    PredictionService.addPrediction(prediction);

    // Non blocking API call
    PredictionService.getPrediction(prediction);
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: _handleAddImage,
      child: const Icon(Icons.add_photo_alternate_outlined),
    );
  }
}
