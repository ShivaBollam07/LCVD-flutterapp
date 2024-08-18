import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:lcdvd/models/prediction_data.dart';

class PredictionCard extends StatelessWidget {
  final PredictionData predictionData;

  const PredictionCard({
    required this.predictionData,
    super.key,
  });

  Future<File?> _loadImage() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = path.join(directory.path, 'images', predictionData.imageName);
      return File(filePath);
    } catch (e) {
      print('Error loading image: $e');
      return null;
    }
  }

  String _formatDateTime(DateTime dateTime) {
    String formattedDate = '${_getMonthName(dateTime.month)} ${dateTime.day}, ${dateTime.year}';
    String formattedTime = '${_padZero(dateTime.hour)}:${_padZero(dateTime.minute)}';
    return '$formattedDate - $formattedTime';
  }

  String _getMonthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }

  String _padZero(int number) {
    return number < 10 ? '0$number' : '$number';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            FutureBuilder<File?>(
              future: _loadImage(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                    width: 100.0,
                    height: 100.0,
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
                  return const SizedBox(
                    width: 100.0,
                    height: 100.0,
                    child: Center(child: Text('Error loading image')),
                  );
                } else {
                  return SizedBox(
                    width: 100.0, // Fixed width to ensure proper layout
                    height: 100.0, // Fixed height to maintain aspect ratio
                    child: Image.file(snapshot.data!, fit: BoxFit.cover),
                  );
                }
              },
            ),
            const SizedBox(width: 16.0), // Space between image and text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    predictionData.prediction ?? 'No prediction',
                    style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    _formatDateTime(predictionData.dateTime!),
                    style: Theme.of(context).textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
