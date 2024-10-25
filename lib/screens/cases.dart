import 'package:flutter/material.dart';

class CasesScreen extends StatefulWidget {
  static final floatingActionButton = FloatingActionButton(
    onPressed: () => {},
    child: const Icon(Icons.create_new_folder_outlined),
  );
  static const title = "Cases";
  const CasesScreen({super.key});

  @override
  State<CasesScreen> createState() => _CasesScreenState();
}

class _CasesScreenState extends State<CasesScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple,
      child: const Text("Cases screen"),
    );
  }
}
