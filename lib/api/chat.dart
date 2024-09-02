import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lcvd/api/endpoints.dart';



Future<String?> getChatResponse(String prompt, String disease) async {

    var chatURL = await EndPointsProvider.getChatURL();
    
    var request = http.MultipartRequest('POST', Uri.parse(chatURL));
    request.fields.addAll(<String, String>{
      "question": prompt,
      "disease_name" : disease,
    });

    var response = await request.send();

    if (response.statusCode == 200) {
      print('File uploaded successfully');
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      var jsonResponse = jsonDecode(responseString);

      // Extract the prediction field
      return jsonResponse['answer'];
    } else {
      print(response.statusCode);
      throw Error();
    }
  
}
