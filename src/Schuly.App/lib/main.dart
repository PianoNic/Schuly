import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

void main() => runApp(const SchulyApp());

class SchulyApp extends StatelessWidget {
  const SchulyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformProvider(
      builder: (context) => const PlatformApp(
        title: 'Schuly',
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(title: const Text('Schuly')),
      body: const Center(child: Text('Hello, Schuly')),
    );
  }
}
