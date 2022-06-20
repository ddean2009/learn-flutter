
import 'package:flutter/material.dart';

class LayoutBuilderApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 600) {
          return buildWidget1();
        } else {
          return buildWidget2();
        }
      },
    );
  }

  Widget buildWidget1() {
    return Center(
      child: Container(
        height: 700.0,
        width: 700.0,
        color: Colors.blue,
      ),
    );
  }

  Widget buildWidget2() {
    return Center(
      child: Container(
        height: 200.0,
        width: 200.0,
        color: Colors.yellow,
      ),
    );
  }



}