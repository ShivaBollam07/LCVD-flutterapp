import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lcvd/models/prediction_data.dart';
import 'package:lcvd/widgets/image_capture_button.dart';
import 'package:lcvd/widgets/prediction_card.dart';


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
