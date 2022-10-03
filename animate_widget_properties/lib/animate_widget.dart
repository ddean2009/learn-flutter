import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(const AnimateWidgetApp());

class AnimateWidgetApp extends StatefulWidget {
  const AnimateWidgetApp({super.key});

  @override
  State<AnimateWidgetApp> createState() => _AnimateWidgetAppState();
}

class _AnimateWidgetAppState extends State<AnimateWidgetApp> {
  double _width = 100;
  double _height = 100;
  Color _color = Colors.blue;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(10);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('动态widget'),
        ),
        body: Center(
          child: AnimatedContainer(
            width: _width,
            height: _height,
            decoration: BoxDecoration(
              color: _color,
              borderRadius: _borderRadius,
            ),
            duration: const Duration(seconds: 1),
            curve: Curves.easeInBack,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              final random = Random();

              _width = random.nextInt(200).toDouble();
              _height = random.nextInt(200).toDouble();

              _color = Color.fromRGBO(
                random.nextInt(256),
                random.nextInt(256),
                random.nextInt(256),
                1,
              );

              _borderRadius =
                  BorderRadius.circular(random.nextInt(10).toDouble());
            });
          },
          child: const Icon(Icons.play_arrow),
        ),
      ),
    );
  }
}