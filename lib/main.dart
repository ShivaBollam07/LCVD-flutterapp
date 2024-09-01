import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lcvd/models/prediction_data.dart';
import 'package:lcvd/widgets/image_capture_button.dart';
import 'package:lcvd/widgets/prediction_card.dart';



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
        primarySwatch: Colors.green, // Set the app's primary theme color
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Box<PredictionData>? predictionBox;

  @override
  void initState() {
    super.initState();
    predictionBox = Hive.box<PredictionData>('predictionBox');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Leaf Curl Virus Detection')),
      body: ValueListenableBuilder(
        valueListenable: predictionBox!.listenable(),
        builder: (context, Box<PredictionData> box, _) {
          if (box.isEmpty) {
            return const Center(
              child: Text('No predictions added yet.'),
            );
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final prediction = box.getAt(index);
              return PredictionCard(predictionData: prediction!, active: prediction.prediction != "Healthy", boxIndex: index,);
            },
          );
        },
      ),
      floatingActionButton: const ImagePickerButton(),
    );
  }
}
