import 'package:flutter/material.dart';
import 'package:lcvd/models/prediction.dart';
import 'package:lcvd/services/format.dart';

class PredictionDataWidget extends StatelessWidget {
  final Prediction prediction;
  const PredictionDataWidget({
    super.key,
    required this.prediction,
  });

  @override
  Widget build(BuildContext context) {
    Color color = prediction.prediction != null
        ? (prediction.prediction!.contains("Healthy")
            ? const Color.fromARGB(255, 193, 244, 195)
            : const Color.fromARGB(255, 227, 173, 169))
        : const Color.fromARGB(255, 191, 167, 96);
    return Container(
        width: MediaQuery.of(context).size.width * 0.95,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            // color: Theme.of(context).colorScheme.surfaceContainer,
            color: color),
        // child: Column(
        //   children: [
        //     Text("Prediction: ${prediction.prediction ?? ""}"),
        //     Divider(
        //       color: const Color.fromARGB(222, 240, 238, 238),
        //     ),
        //     Text("Date and Time: ${formatDateTime(prediction.dateTime)}"),
        //     Text("Case: ${prediction.caseName}"),
        //   ],
        // ),
        child: Table(
          border: TableBorder(
            horizontalInside: BorderSide(
                width: 1,
                color: Theme.of(context)
                    .colorScheme
                    .surfaceBright), // Row separators
          ),
          columnWidths: const {
            0: IntrinsicColumnWidth(), // Aligns the first column's width based on the content
            1: FlexColumnWidth(), // Makes the second column fill the remaining space
          },
          children: [
            TableRow(children: [
              const Padding(
                padding: EdgeInsets.all(15),
                child: Text("Prediction:",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black)),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  prediction.prediction ?? "",
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ]),
            TableRow(children: [
              const Padding(
                padding: EdgeInsets.all(15),
                child: Text("Date and Time:",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black)),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  formatDateTime(prediction.dateTime),
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ]),
            TableRow(children: [
              const Padding(
                padding: EdgeInsets.all(15),
                child: Text("Case:",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black)),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  prediction.caseName ?? "Null",
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ]),
          ],
        ));
  }
}
