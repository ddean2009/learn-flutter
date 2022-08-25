import 'package:flutter/material.dart';
import 'package:state_management/student_inherited_widget3.dart';

class StudentModel3 {
  const StudentModel3({ this.age = 18 });

  final int age;


  static StudentModel3 of(BuildContext context) {
    final StudentInheritedWidget3? inheritedWidget = context.dependOnInheritedWidgetOfExactType<StudentInheritedWidget3>();
    return inheritedWidget!.modelBindingState.currentModel;
  }

  static void update(BuildContext context, StudentModel3 newModel) {
    final StudentInheritedWidget3? inheritedWidget = context.dependOnInheritedWidgetOfExactType<StudentInheritedWidget3>();
    inheritedWidget!.modelBindingState.updateModel(newModel);
  }
}
