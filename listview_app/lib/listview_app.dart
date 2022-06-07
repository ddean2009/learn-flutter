
import 'package:flutter/material.dart';

class ListViewApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return GridView.extent(
        maxCrossAxisExtent: 100,
        padding: const EdgeInsets.all(4),
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: buildChild(10));
  }

  List<Widget> buildChild(int number) {
    return List.generate(
        number, (i) => Container(
        child: Image.asset('images/head.jpg')));
  }
}