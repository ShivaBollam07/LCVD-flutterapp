import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiSettings extends StatefulWidget {
  const ApiSettings({super.key});

  @override
  ApiSettingsState createState() => ApiSettingsState();
}

class ApiSettingsState extends State<ApiSettings> {
  final _formKey = GlobalKey<FormState>();

  // Controllers to capture the input
  final TextEditingController _imagePredictionURLController =
      TextEditingController();
  final TextEditingController _chatURLController = TextEditingController();

  @override
  void dispose() {
    _imagePredictionURLController.dispose();
    _chatURLController.dispose();
    super.dispose();
  }

  void _saveForm() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    if (_formKey.currentState?.validate() ?? false) {
      // If the form is valid, print the values
      await sharedPreferences.setString(
          "imagePredictionURL", _imagePredictionURLController.text);
      await sharedPreferences.setString("chatURL", _chatURLController.text);
      _imagePredictionURLController.clear();
      _chatURLController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _imagePredictionURLController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Prediction URL',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid URL';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _chatURLController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Chat URL',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid URL';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: _saveForm,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: ApiSettings(),
  ));
}
