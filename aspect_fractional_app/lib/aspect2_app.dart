
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Aspect2App extends StatelessWidget{

  const Aspect2App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      alignment: Alignment.center,
      width: 150.0,
      height: 150.0,
      child: AspectRatio(
        aspectRatio: 2.0,
        child: Container(
          color: Colors.red,
          width: 50,
          height: 50,
        ),
      ),
    );
  }

}