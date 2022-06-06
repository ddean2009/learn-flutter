
import 'package:flutter/material.dart';

class ContainerAppTransform extends  StatelessWidget {

  const ContainerAppTransform({Key? key}) : super(key: key);

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
          // transform: Matrix4.rotationZ(0.2),
          transform: Matrix4.rotationX(0.5),
        width: 100,
        child: Image.asset("images/head.jpg")
      )
    ],
  );


}