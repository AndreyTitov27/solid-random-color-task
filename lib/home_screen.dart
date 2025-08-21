import 'package:flutter/material.dart';
import 'package:solid_random_color_task/random_color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const _animationDuration = Duration(milliseconds: 300);

  late Color _backgroundColor;
  late String _backgroundColorHex;
  final List<Color> _colorHistory = [];
  int _currentIndex = 0;

  @override
  void didChangeDependencies() { // Initialize the first color
    super.didChangeDependencies();
    if (_colorHistory.isEmpty) {
      _backgroundColor = Theme.of(context).colorScheme.surface;
      _colorHistory.add(_backgroundColor);
      _backgroundColorHex = colorToHex(_backgroundColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: _handleOnTap,
        onDoubleTap: _handleOnDoubleTap,
        child: AnimatedContainer(
          color: _backgroundColor,
          duration: _animationDuration,
          curve: Curves.easeInOut,
          child:Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedDefaultTextStyle(
                style: getAdaptiveTextStyle(context, 28.0),
                curve: Curves.easeInOut,
                duration: _animationDuration,
                child: Text('Hello there'),
              ),
              AnimatedDefaultTextStyle(
                style: getAdaptiveTextStyle(context, 20.0),
                curve: Curves.easeInOut,
                duration: _animationDuration,
                child: Text(_backgroundColorHex),
              ),
            ],
          ),),
        ),
      ),
    );
  }

  void _handleOnTap() {
    setState(() {
      if (_currentIndex == _colorHistory.length - 1) {
        _colorHistory.add(generateRandomColor());
      }
        _backgroundColor = _colorHistory[++_currentIndex];
        _backgroundColorHex = colorToHex(_backgroundColor);
    });
  }
  void _handleOnDoubleTap() {
    if (_colorHistory.isNotEmpty && _currentIndex > 0) {
      setState(() {
        _backgroundColor = _colorHistory[--_currentIndex];
        _backgroundColorHex = colorToHex(_backgroundColor);
      });
    }
  }

  TextStyle getAdaptiveTextStyle(BuildContext context, double fontSize) => TextStyle(
    color: ThemeData.estimateBrightnessForColor(_backgroundColor) == Brightness.light
      ? Theme.of(context).colorScheme.onSurface
      : Theme.of(context).colorScheme.onInverseSurface,
    fontSize: fontSize,
  );

  String colorToHex(Color color) => '#${color.toARGB32().toRadixString(16).padLeft(8, '0').substring(2)}';
}