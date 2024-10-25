import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lcvd/models/prediction.dart';
import 'package:lcvd/screens/prediction_details.dart';
import 'package:lcvd/services/format.dart';
import 'package:lcvd/services/prediction_service.dart';

class PredictionGridItem extends StatelessWidget {
  final Prediction predictionData;

  const PredictionGridItem({
    required this.predictionData,
    super.key,
  });

  void _navigateToDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PredictionDetailsPage(
          prediction: predictionData,
        ),
      ),
    );
  }

  void _confirmDeletion(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Prediction"),
          content:
              const Text("Are you sure you want to delete this prediction?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                PredictionService.deletePrediction(predictionData);
                Navigator.of(context).pop();
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _navigateToDetails(context),
      onLongPress: () => _confirmDeletion(context), // Long press to delete
      child: Card(
        color: Theme.of(context).colorScheme.surfaceContainer,
        elevation: 0,
        margin: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FutureBuilder<File?>(
              future: PredictionService.loadImageFile(predictionData),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                    width: double.infinity,
                    height: 150.0,
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (snapshot.hasError ||
                    !snapshot.hasData ||
                    snapshot.data == null) {
                  return const SizedBox(
                    width: double.infinity,
                    height: 150.0,
                    child: Center(child: Text('Error loading image')),
                  );
                } else {
                  return ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16.0),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 150.0,
                      child: Image.file(snapshot.data!, fit: BoxFit.cover),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                predictionData.prediction ?? 'Processing ...',
                style: const TextStyle(
                    fontSize: 14.0, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            const SizedBox(height: 4.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                formatDateTime(predictionData.dateTime),
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
