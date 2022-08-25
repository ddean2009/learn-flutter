import 'package:flutter/material.dart';
import 'package:state_management/student_Inherited_widget.dart';

class StudentModel2 {
  const StudentModel2({ this.age = 18 });
  final int age;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentModel2 &&
          runtimeType == other.runtimeType &&
          age == other.age;

  @override
  int get hashCode => age.hashCode;

  static StudentModel2 of(BuildContext context) {
    final StudentInheritedWidget? inheritedWidget = context.dependOnInheritedWidgetOfExactType<StudentInheritedWidget>();
    return inheritedWidget!.model;
  }
}
