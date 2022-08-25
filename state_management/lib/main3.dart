import 'package:flutter/material.dart';
import 'package:state_management/student_controller3.dart';
import 'package:state_management/student_inherited_widget3.dart';
import 'package:state_management/student_model3.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ModelBinding3(
        initialModel: StudentModel3(),
        child: Scaffold(
          body: Center(
            child: StudentController3(),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(App());
}