// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:lcdvd/models/prediction_data.dart';
// import 'package:lcdvd/widgets/image_capture_button.dart';

// void main() async {
//   await Hive.initFlutter();
//   Hive.registerAdapter(PredictionDataAdapter());
//   await Hive.openBox<PredictionData>('predictionBox');
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.green, // Set the app's primary theme color
//       ),
//       home: const HomePage(),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   late Box<PredictionData> predictionBox;

//   @override
//   void initState() {
//     super.initState();
//     predictionBox = Hive.box<PredictionData>('predictionBox');
//   }

//   void _addPrediction(PredictionData data) {
//     predictionBox.add(data);
//     setState(() {
      
//     });
//   }

//   List<PredictionData> _getPredictions() {
//     return predictionBox.values.toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // floatingActionButton: FloatingActionButton(
//       //   onPressed: () {
//       //     _showImageAlertDialog(context);
//       //   },
//       //   child: const Icon(Icons.add),
//       // ),
//       // appBar: AppBar(
//       //   title: const Text('AlertDialog with Image'),
//       // ),
//       // body: ListView.separated(
//       //     padding: const EdgeInsets.all(10),
//       //     itemBuilder: (context, index) {
//       //       return _buildCard(index);
//       //     },
//       //     separatorBuilder: (context, index) => const SizedBox(
//       //           height: 10,
//       //         ),
//       //     itemCount: 100));
//       appBar: AppBar(title: const Text('Predictions')),
//       body: ListView.builder(
//         itemCount: _getPredictions().length,
//         itemBuilder: (context, index) {
//           final prediction = _getPredictions()[index];
//           return ListTile(
//             title: Text(prediction.prediction ?? ''),
//             subtitle: Text(prediction.dateTime?.toString() ?? ''),
//           );
//         },
//       ),
//       // floatingActionButton: FloatingActionButton(
//       //   onPressed: () {
//       //     _addPrediction(PredictionData(
//       //       prediction: "New Prediction",
//       //       dateTime: DateTime.now(),
//       //       imageName: "new_image.png",
//       //     ));
//       //   },
//       //   child: const Icon(Icons.add),
//       // ),
//       floatingActionButton: const ImagePickerButton(),
//     );
//   }

//   Widget _buildCard(int index) => ClipRRect(
//         borderRadius: BorderRadius.circular(20),
//         child: Container(
//           color: const Color.fromARGB(255, 255, 193, 188),
//           // child: ,
//           height: 150,
//         ),
//       );

// // Function to display the AlertDialog with an image
//   void _showImageAlertDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Image Alert Dialog'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               Image.network(
//                   "https://miro.medium.com/v2/resize:fit:1200/1*AoY2OAjg318aCY396JUM6w.png"),
//               const SizedBox(height: 16), // Adjust spacing as needed
//               const Text('This is your image description.'),
//             ],
//           ),
//           actions: <Widget>[
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the AlertDialog
//               },
//               child: const Text('Close'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
