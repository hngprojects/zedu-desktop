import 'package:flutter/widgets.dart';
import 'package:zedu/core/core.dart';

class MockHomeScreen extends StatelessWidget {
  const MockHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mock Home')),
      body: const Center(
        child: Text('Welcome to the Mock Home Screen!'),
      ),
    );
  }
}