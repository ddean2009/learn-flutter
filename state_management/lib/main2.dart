import 'package:flutter/material.dart';
import 'package:state_management/student_Inherited_widget.dart';
import 'package:state_management/student_controller2.dart';
import 'package:state_management/student_model2.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  StudentModel2 currentModel = const StudentModel2();

  void updateModel(StudentModel2 newModel) {
    if (newModel != currentModel) {
      setState(() {
        currentModel = newModel;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StudentInheritedWidget(
        model: currentModel,
        child: Scaffold(
          body: Center(
            child: StudentController2(updateModel: updateModel),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const App());
}