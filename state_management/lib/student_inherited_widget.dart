import 'package:flutter/material.dart';
import 'package:state_management/student_model2.dart';

class StudentInheritedWidget extends InheritedWidget {
  const StudentInheritedWidget({
     Key? key,
    this.model = const StudentModel2(),
    required Widget child,
  }) : super(key: key, child: child);

  final StudentModel2 model;

  @override
  bool updateShouldNotify(StudentInheritedWidget oldWidget) => model != oldWidget.model;
}