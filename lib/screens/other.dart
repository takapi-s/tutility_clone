//時間割の画面

import 'package:flutter/material.dart';

class OtherScreen extends StatelessWidget {
  const OtherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Other'),
      ),
      body: const Center(
          child: Text('Other画面', style: TextStyle(fontSize: 32.0))
      ),
    );
  }
}