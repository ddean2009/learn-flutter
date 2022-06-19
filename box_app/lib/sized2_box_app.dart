
import 'package:flutter/material.dart';

class Sized2BoxApp extends StatelessWidget{

  Sized2BoxApp({Key? key}) : super(key: key);

  final list = [Colors.red, Colors.blue, Colors.black, Colors.yellow];

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        color: Colors.blue,
      ),
    );
  }



}