import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lcvd/pages/prediction_details_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:lcvd/models/prediction_data.dart';

class PredictionCard extends StatelessWidget {
  final PredictionData predictionData;
  final bool active;
  final int boxIndex;

  const PredictionCard({
    required this.predictionData,
    required this.active,
    required this.boxIndex,
    super.key,
  });

  Future<File?> _loadImage() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath =
          path.join(directory.path, 'images', predictionData.imageName);
      return File(filePath);
    } catch (e) {
      print('Error loading image: $e');
      return null;
    }
  }

  String _formatDateTime(DateTime dateTime) {
    String formattedDate =
        '${_getMonthName(dateTime.month)} ${dateTime.day}, ${dateTime.year}';
    String formattedTime =
        '${_padZero(dateTime.hour)}:${_padZero(dateTime.minute)}';
    return '$formattedDate - $formattedTime';
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }



  String _padZero(int number) {
    return number < 10 ? '0$number' : '$number';
  }

  void _navigateToDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PredictionDetailsPage(
          predictionData: predictionData,
          boxIndex: boxIndex,
        ),
      ),
    );
  }

  void _handleDelete(BuildContext context) {
    var predictionBox = Hive.box<PredictionData>('predictionBox');
    predictionBox.deleteAt(boxIndex);
    
    if (Navigator.canPop(context)){
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: active ? () => _navigateToDetails(context) : null,
      child: Card(
        color: Theme.of(context).colorScheme.surfaceContainer,
        elevation: 0,
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(15),
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
                  } else if (snapshot.hasError ||
                      !snapshot.hasData ||
                      snapshot.data == null) {
                    return const SizedBox(
                      width: 100.0,
                      height: 100.0,
                      child: Center(child: Text('Error loading image')),
                    );
                  } else {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(
                          16.0), // Adjust the radius as needed
                      child: SizedBox(
                        width: 100.0, // Fixed width to ensure proper layout
                        height: 100.0, // Fixed height to maintain aspect ratio
                        child: Image.file(snapshot.data!, fit: BoxFit.cover),
                      ),
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
                      style: const TextStyle(
                          fontSize: 14.0, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
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
              IconButton(onPressed: ()=>_handleDelete(context), icon: const Icon(Icons.delete))
            ],
          ),
        ),
      ),
    );
  }
}
