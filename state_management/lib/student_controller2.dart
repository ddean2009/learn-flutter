
import 'package:flutter/material.dart';
import 'package:state_management/student_model2.dart';

class StudentController2 extends StatelessWidget {
  const StudentController2({ Key? key, required this.updateModel }) : super(key: key);

    final ValueChanged<StudentModel2> updateModel;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        updateModel(StudentModel2(age: StudentModel2.of(context).age + 1));
      },
      child: Text('你的年龄是: ${StudentModel2.of(context).age}'),
    );
  }
}
