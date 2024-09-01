import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lcvd/api/chat.dart';
import 'package:lcvd/models/prediction_data.dart';
import 'package:lcvd/widgets/prediction_card.dart';

class PredictionDetailsPage extends StatefulWidget {
  final PredictionData predictionData;
  final int boxIndex;
  const PredictionDetailsPage({
    super.key,
    required this.predictionData,
    required this.boxIndex,
  });

  @override
  PredictionDetailsPageState createState() => PredictionDetailsPageState();
}

class PredictionDetailsPageState extends State<PredictionDetailsPage> {
  List<String> options = [
    'What is this disease?',
    'What are the possible cures?',
    'What causes this disease?',
    'What are the common symptoms?',
    'What is the traditional diagnosis?',
    'What are the preventive measures?',
  ];

  Box<PredictionData>? predictionBox;
  late List<String> messages;

  @override
  void initState() {
    super.initState();
    predictionBox = Hive.box<PredictionData>('predictionBox');
    if (predictionBox == null) {
      print("prediction box is null");
    }
    messages = predictionBox!.getAt(widget.boxIndex)!.chat!;
  }

  bool isBotResponding = false;

  void setMessages() {
    var current = predictionBox!.getAt(widget.boxIndex);
    current!.chat = messages;
    predictionBox!.putAt(widget.boxIndex, current);
  }

  void _sendMessage(String message) async {
    setState(() {
      messages.add(message);
      setMessages();
      messages.add("Loading...");
      isBotResponding = true;
    });

    try {
      String? response = await getChatResponse(message, widget.predictionData.prediction!);
      setState(() {
        messages[messages.length - 1] = response!;
        isBotResponding = false;
        setMessages();
      });
    } catch (e) {
      print("came here");
      setState(() {
        messages[messages.length - 1] = e.toString();
        isBotResponding = false;
        setMessages();
      });
    }
    // Future.delayed(const Duration(seconds: 2), () {
    //   setState(() {
    //     messages[messages.length - 1] =
    //         "Bot: You selected $message lorem halkdjfa fahdkjfha dahdfklad ajdhfkjad fjadhfkajdf adfbajkldf ajdfkjadf jadhfkadf akdhfkadf akhdfkadskf aldsfhkjadfkla";
    //     isBotResponding = false;
    //     setMessages();
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Details")),
      body: Container(
        color: Colors.grey[200], // Background color for the entire page
        child: Column(
          children: <Widget>[
            PredictionCard(
                predictionData: widget.predictionData,
                active: false,
                boxIndex: widget.boxIndex),
            Expanded(
              child: ListView.builder(
                itemCount: messages.length + 1, // +1 for options
                itemBuilder: (context, index) {
                  if (index < messages.length) {
                    // Display chat messages
                    bool isUserMessage = index % 2 == 0;
                    return Align(
                      alignment: isUserMessage
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.sizeOf(context).width * 3 / 4),
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          margin: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 10.0),
                          decoration: BoxDecoration(
                            color: isUserMessage
                                ? Colors.blue[100]
                                : Colors.green[100],
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text(
                            messages[index],
                            style: TextStyle(
                              color: isUserMessage
                                  ? Colors.blue[800]
                                  : Colors.green[800],
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    // Display options after the last message
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: widget.predictionData.prediction == "Healthy" 
                      ? <Widget>[] 
                      : options.map((option) {
                        return Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            margin: const EdgeInsets.symmetric(
                                vertical: 1.0, horizontal: 10.0),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 115, 121,
                                  126), // Slightly darker color than messages
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: InkWell(
                              onTap: isBotResponding
                                  ? null
                                  : () => _sendMessage(option),
                              child: Text(
                                option,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: isBotResponding
                                      ? Colors.grey
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
