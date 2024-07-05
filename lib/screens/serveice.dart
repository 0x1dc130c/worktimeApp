import 'package:flutter/material.dart';

class ServeicePage extends StatelessWidget {
  const ServeicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Serveice Page'),
      ),
      body: const Center(
        child: Text('Welcome to the Serveice Page!'),
      ),
    );
  }
}