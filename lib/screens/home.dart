import 'package:flutter/material.dart';
// import 'package:lcvd/screens/cases.dart';
import 'package:lcvd/screens/predictions.dart';
import 'package:lcvd/screens/settings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  bool isListLayout = false;

  final _floatingActionButtons = <Widget?>[
    PredictionsScreen.floatingActionButton,
    // null,
    null
  ];

  @override
  Widget build(BuildContext context) {
    Widget currentScreen;

    if (currentIndex == 0) {
      currentScreen = PredictionsScreen(isListLayout: isListLayout);
      // } else if (currentIndex == 1) {
      //   currentScreen = const CasesScreen();
    } else {
      currentScreen = const SettingsScreen();
    }

    List<Widget> actions;
    if (currentIndex == 0) {
      actions = [
        IconButton(
          onPressed: () {
            setState(() {
              isListLayout = !isListLayout;
            });
          },
          icon: isListLayout
              ? const Icon(Icons.grid_view)
              : const Icon(Icons.format_list_bulleted_rounded),
        ),
        const SizedBox(
          width: 7,
        )
      ];
    } else {
      actions = [];
    }

    final titles = <String>[
      PredictionsScreen.title,
      // CasesScreen.title,
      SettingsScreen.title
    ];

    return Scaffold(
      floatingActionButton: _floatingActionButtons[currentIndex],
      appBar: AppBar(title: Text(titles[currentIndex]), actions: actions),
      body: currentScreen,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        destinations: const <Widget>[
          NavigationDestination(
              icon: Icon(Icons.science), label: "Predictions"),
          // NavigationDestination(icon: Icon(Icons.folder_copy), label: "Cases"),
          NavigationDestination(icon: Icon(Icons.settings), label: "Settings")
        ],
        onDestinationSelected: (value) => setState(() {
          currentIndex = value;
        }),
      ),
    );
  }
}
