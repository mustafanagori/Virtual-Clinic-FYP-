import 'package:flutter/material.dart';

class Conference extends StatelessWidget {
  const Conference({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("Conference Room"),
      ),
    );
  }
}
