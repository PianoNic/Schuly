import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'ui/home/widgets/home_screen.dart';

void main() => runApp(const SchulyApp());

class SchulyApp extends StatelessWidget {
  const SchulyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformProvider(
      builder: (context) => const PlatformApp(
        title: 'Schuly',
        home: HomeScreen(),
      ),
    );
  }
}
