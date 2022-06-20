import 'package:flutter/material.dart';

class BuilderApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) {
          return Center(
            child: TextButton(
              onPressed: () {
                print(Scaffold.of(context).hasAppBar);
              },
              child: Text('TextButton'),
            ),
          );
        },
      ),
    );
  }

}