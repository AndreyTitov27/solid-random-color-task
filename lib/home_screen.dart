import 'package:flutter/material.dart';
import 'package:solid_random_color_task/random_color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Color _backgroundColor;
  final List<Color> _colorHistory = [];
  int _currentIndex = 0;
  
  @override
  void didChangeDependencies() { // Initialize the first color
    _backgroundColor = Theme.of(context).colorScheme.surface;
    _colorHistory.add(_backgroundColor);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: AnimatedContainer(
          color: _backgroundColor,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: Center(
            child: AnimatedDefaultTextStyle(
              style: TextStyle(
                color: ThemeData.estimateBrightnessForColor(_backgroundColor) == Brightness.light
                  ? Theme.of(context).colorScheme.onSurface
                  : Theme.of(context).colorScheme.onInverseSurface,
                fontSize: 28.0,
              ),
              curve: Curves.easeInOut,
              duration: Duration(milliseconds: 300),
              child: Text('Hello there'),
            ),
          ),
        ),
        onTap: () {
          setState(() {
            if (_currentIndex == _colorHistory.length - 1) {
              _colorHistory.add(generateRandomColor());
            }
            _backgroundColor = _colorHistory[++_currentIndex];

          });
        },
        onDoubleTap: () {
          if (_colorHistory.isNotEmpty && _currentIndex > 0) {
            setState(() {
              _backgroundColor = _colorHistory[--_currentIndex];
            });
          }
        },
      ),
    );
  }
}