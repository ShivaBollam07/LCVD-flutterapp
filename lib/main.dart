import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lcvd/models/prediction_data.dart';
import 'package:lcvd/pages/home.dart';



void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(PredictionDataAdapter());
  await Hive.openBox<PredictionData>('predictionBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        // colorScheme: ColorScheme.fromSwatch(
        //   primarySwatch: Colors.purple,
        // ).copyWith(
        //   secondary: Colors.deepPurpleAccent,
        // ),
        useMaterial3: true, // Optional, for Material You support
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.green,
        // colorScheme: ColorScheme.dark().copyWith(
        //   primary: Colors.deepPurple,
        //   secondary: Colors.deepPurpleAccent,
        // ),
        useMaterial3: true, // Optional, for Material You support
      ),
      themeMode: ThemeMode.system, // Automatically switch based on system settings
      home: const HomePage(),
    );
  }
}

