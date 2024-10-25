import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lcvd/models/prediction.dart';
import 'package:lcvd/services/prediction_service.dart';
import 'package:lcvd/widgets/add_image.dart';
import 'package:lcvd/widgets/prediction_list_item.dart';
import 'package:lcvd/widgets/prediction_tile.dart';

class PredictionsScreen extends StatefulWidget {
  final bool isListLayout;
  static const title = "Predictions";

  static final actions = <Widget>[];

  static const floatingActionButton = AddImageFAB();

  const PredictionsScreen({super.key, required this.isListLayout});

  @override
  State<PredictionsScreen> createState() => _PredictionsScreenState();
}

class _PredictionsScreenState extends State<PredictionsScreen> {
  Box<Prediction> box = PredictionService.box;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: PredictionService.getListenable(),
      builder: (context, box, _) {
        if (box.isEmpty) {
          return const Center(
            child: Text('No predictions added yet.'),
          );
        }

        // return ;

        return widget.isListLayout
            ? ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemCount: box.length,
                itemBuilder: (context, index) {
                  final prediction = box.getAt(index);
                  return PredictionItem(predictionData: prediction!);
                },
              )
            : GridView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of grid columns
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio:
                      0.8, // Adjust for the aspect ratio of each grid tile
                ),
                itemCount: box.length,
                itemBuilder: (context, index) {
                  final prediction = box.getAt(index);
                  return PredictionGridItem(predictionData: prediction!);
                },
              );
      },
    );
  }
}
