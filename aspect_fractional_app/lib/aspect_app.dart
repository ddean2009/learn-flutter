
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AspectApp extends StatelessWidget{

  const AspectApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      alignment: Alignment.center,
      width: double.infinity,
      height: 150.0,
      child: AspectRatio(
        aspectRatio: 3 / 2,
        child: Container(
          color: Colors.red,
        ),
      ),
    );

  }

}