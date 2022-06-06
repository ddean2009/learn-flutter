
import 'package:flutter/material.dart';

class ContainerApp extends  StatelessWidget {

  const ContainerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          buildBoxRow(),
          buildBoxRow(),
        ],
      ),
    );
  }

  Widget buildBoxRow()  => Row(
    textDirection: TextDirection.ltr,
    children: [
      Container(
        width: 100,
        child: Image.asset("images/head.jpg")
      )
    ],
  );


}