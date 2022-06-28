import 'dart:math';

import 'package:flutter/material.dart';

class TransformApp extends StatelessWidget{
  Widget build(BuildContext context) {
    // return Center(
    //   child: Transform.rotate(
    //     angle: pi/4,
    //     child: const Icon(
    //         Icons.airplanemode_active,
    //         size: 200,
    //       color: Colors.blue,
    //     ),
    //   ));

    // return Transform.translate(
    //       offset:const Offset(50.0, 100.0),
    //       child: const Icon(
    //         Icons.airplanemode_active,
    //         size: 200,
    //         color: Colors.blue,
    //       ),
    //     );

    return Transform.scale(
      scale: 0.5,
      child: const Icon(
        Icons.airplanemode_active,
        size: 200,
        color: Colors.blue,
      ),
    );
  }

}
