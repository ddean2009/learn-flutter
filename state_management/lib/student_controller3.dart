
import 'package:flutter/material.dart';
import 'package:state_management/student_model2.dart';
import 'package:state_management/student_model3.dart';

class StudentController3 extends StatelessWidget {
  const StudentController3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final StudentModel3 model = StudentModel3.of(context);
        StudentModel3.update(context, StudentModel3(age: model.age + 1));
      },
      child: Text('你的年龄是 ${StudentModel3.of(context).age}'),
    );
  }
}

