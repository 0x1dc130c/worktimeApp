import 'package:flutter/material.dart';

class CalculatePage extends StatelessWidget {
  const CalculatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculate'),
      ),
      body: const Center(
        child: Text(
          'Calculate Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}