import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RowWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.ltr,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        YellowBox(),
        YellowBox(),
        Expanded(
          child: YellowBox(),
        ),
        YellowBox(),
        YellowBox(),
      ],
    );
  }
}

class YellowBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.yellow,
        border: Border.all(),
      ),
    );
  }
}