
import 'package:flutter/material.dart';

class ListViewSeparatedApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
           itemCount: 10,
           separatorBuilder: (BuildContext context, int index) => const Divider(color: Colors.black,),
           itemBuilder: (BuildContext context, int index) {
             return Container(
                 constraints: const BoxConstraints(maxWidth:50,maxHeight: 50),
               child: Image.asset('images/head.jpg')
             );
           },
         );
  }
}