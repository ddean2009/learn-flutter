
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatefulBuilderApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Builder(
        builder: (BuildContext context) {
          int clicked = 0;
          return Center(
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                    return TextButton(onPressed: (){
                      setState(() => {clicked = 1 });
                    },
                        child: Text('TextButton'));
                  }),
                );
        },
      ),
    );
  }

}