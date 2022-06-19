
import 'package:flutter/material.dart';

class FittedBoxApp extends StatelessWidget{

  FittedBoxApp({Key? key}) : super(key: key);

  final list = [Colors.red, Colors.blue, Colors.black, Colors.yellow];

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fill,
      child: Image.asset('images/head.jpg'),
    );
  }



}