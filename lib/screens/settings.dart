import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:lcvd/screens/api_settings.dart';

class SettingsScreen extends StatefulWidget {
  static const title = "Settings";
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkTheme = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          // tileColor: Theme.of(context).colorScheme.surfaceContainer,
          minTileHeight: 100,
          title: const Text("Dark Theme"),
          trailing: Switch(
            value: AdaptiveTheme.of(context).mode.isDark,
            onChanged: (value) {
              if (value) {
                AdaptiveTheme.of(context).setDark();
              } else {
                AdaptiveTheme.of(context).setLight();
              }
            },
          ),
        ),
        ListTile(
          title: const Text("API Settings"),
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ApiSettings(),
              ),
            )
          },
        )
      ],
    );
  }
}
