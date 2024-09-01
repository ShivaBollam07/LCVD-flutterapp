import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:lcvd/api/endpoints.dart';
import 'package:lcvd/models/prediction_data.dart';
import 'package:path/path.dart' as path;

Future<PredictionData?> uploadFile(File file) async {
  try {
    var dateTime = DateTime.now();
    // Create a multipart request
    var request = http.MultipartRequest('POST', Uri.parse(ImagePredictionURL));

    // Attach the file to the request
    var fileStream = http.ByteStream(file.openRead());
    var fileLength = await file.length();
    var multipartFile = http.MultipartFile(
      'image', // The name of the file field on the server
      fileStream,
      fileLength,
      filename: path.basename(file.path),
    );
    request.files.add(multipartFile);

    var response = await request.send();

    if (response.statusCode == 200) {
      print('File uploaded successfully');
      
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      var jsonResponse = jsonDecode(responseString);

      if (jsonResponse['success'] == true) {
        String? prediction = jsonResponse['prediction'];

        return PredictionData(
          prediction: prediction,
          dateTime: dateTime,
          imageName: path.basename(file.path),
          chat: List<String>.empty(growable: true)
        );
      } else {
        print('File upload failed: Server returned success = false');
        return null;
      }
    } else {
      print('File upload failed: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error uploading file: $e');
    return null;
  }
}
