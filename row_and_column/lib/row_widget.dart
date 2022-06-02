import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RowWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.ltr,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      // children: [
      //   YellowBox(),
      //   YellowBox(),
      //   Expanded(
      //     child: YellowBox(),
      //   )
      // ],
      children: [
        Expanded(
          child: YellowBox(),
        ),
        // SizedBox(
        //   width: 100,
        // ),
        Spacer(flex: 2),
        Expanded(
          child: YellowBox(),
        ),
        Expanded(
          flex: 2,
          child: YellowBox(),
        )
      ],
    );
  }
}

class YellowBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.yellow,
        border: Border.all(),
      ),
    );
  }
}