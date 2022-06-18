import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FractionalApp extends StatelessWidget{

  const FractionalApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return FractionallySizedBox(
      widthFactor: 1,
      heightFactor: 0.25,
      alignment: FractionalOffset.center,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.red,
            width: 4,
          ),
        ),
      ),
    );
  }

}