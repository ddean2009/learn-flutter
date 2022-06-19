
import 'package:flutter/material.dart';

class SizedBoxApp extends StatelessWidget{

  SizedBoxApp({Key? key}) : super(key: key);

  final list = [Colors.red, Colors.blue, Colors.black, Colors.yellow];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.0,
      height: 200.0,
      child: Container(
        color: Colors.blue,
      ),
    );
  }



}