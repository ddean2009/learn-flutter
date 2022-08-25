
import 'package:flutter/material.dart';
import 'package:state_management/student_model1.dart';

class StudentController1 extends StatefulWidget {
  const StudentController1({Key? key}) : super(key: key);

  @override
  _StudentControllerState1 createState() => _StudentControllerState1();
}

class _StudentControllerState1 extends State<StudentController1> {
  StudentModel1 currentModel = const StudentModel1();

  void updateModel(StudentModel1 newModel) {
    if (newModel != currentModel) {
      setState(() {
        currentModel = newModel;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        updateModel(StudentModel1(age: currentModel.age + 1));
      },
      child: Text('你的年龄是: ${currentModel.age}'),
    );
  }
}