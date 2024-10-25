import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lcvd/models/prediction.dart';
import 'package:lcvd/screens/home.dart';
import 'package:lcvd/services/prediction_service.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(PredictionAdapter());
  await Hive.openBox<Prediction>(PredictionService.boxName);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
        light: ThemeData.light(useMaterial3: true),
        dark: ThemeData.dark(useMaterial3: true),
        initial: AdaptiveThemeMode.dark,
        builder: (theme, darkTheme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Adaptive Theme Demo',
            theme: theme,
            darkTheme: darkTheme,
            home: const HomeScreen(),
          );
        });
  }
}
