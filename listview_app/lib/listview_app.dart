
import 'package:flutter/material.dart';

class ListViewApp extends StatelessWidget{
  const ListViewApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        return Container(
            constraints: const BoxConstraints(maxWidth:100,maxHeight: 100),
            child: Image.asset('images/head.jpg')
        );
      },
    );
  }
}