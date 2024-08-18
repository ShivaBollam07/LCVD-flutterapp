import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:lcvd/models/prediction_data.dart';
import 'package:path/path.dart' as path;

Future<PredictionData?> uploadFile(File file, String url) async {
  try {
    var dateTime = DateTime.now();
    // Create a multipart request
    var request = http.MultipartRequest('POST', Uri.parse(url));

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

    // Send the request
    var response = await request.send();

    // Handle the response
    if (response.statusCode == 200) {
      print('File uploaded successfully');
      
      // Parse the response
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      var jsonResponse = jsonDecode(responseString);

      // Extract the prediction field
      if (jsonResponse['success'] == true) {
        String? prediction = jsonResponse['prediction'];

        // Create and return the PredictionData object
        return PredictionData(
          prediction: prediction,
          dateTime: dateTime,
          imageName: path.basename(file.path),
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
