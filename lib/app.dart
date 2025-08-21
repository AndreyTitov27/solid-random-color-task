import 'package:flutter/material.dart';
import 'package:solid_random_color_task/home_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      title: 'Random color',
    );
  }
}
