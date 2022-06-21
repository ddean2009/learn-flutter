import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WrapWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      spacing: 10,
      runSpacing: 10,
      textDirection: TextDirection.ltr,
      children: [
        YellowBox(),
        YellowBox(),
        // Expanded(
        //   child: YellowBox(),
        // ),
        YellowBox(),
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