
import 'package:flutter/material.dart';

class LimitedBoxApp extends StatelessWidget{

  LimitedBoxApp({Key? key}) : super(key: key);

  final list = [Colors.red, Colors.blue, Colors.black, Colors.yellow];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for(var i=0; i < 10 ; i++)
          LimitedBox(
            maxHeight: 100,
            child: Container(
              // height: 100,
              color: list[i % 4],
            ),
          )

      ],
    );
  }



}