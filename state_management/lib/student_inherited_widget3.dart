import 'package:flutter/material.dart';
import 'package:state_management/student_model3.dart';

class StudentInheritedWidget3 extends InheritedWidget {
  const StudentInheritedWidget3({
    Key? key,
    required this.modelBindingState,
    required Widget child,
  }) : super(key: key, child: child);

  final _ModelBindingState3 modelBindingState;

  @override
  bool updateShouldNotify(StudentInheritedWidget3 oldWidget) => true;
}


class ModelBinding3 extends StatefulWidget {
  const ModelBinding3({
    Key? key,
    this.initialModel = const StudentModel3(),
    required this.child,
  }) : super(key: key);

  final StudentModel3 initialModel;
  final Widget child;

  @override
  _ModelBindingState3 createState() => _ModelBindingState3();
}

class _ModelBindingState3 extends State<ModelBinding3> {
  late StudentModel3 currentModel;

  @override
  void initState() {
    super.initState();
    currentModel = widget.initialModel;
  }

  void updateModel(StudentModel3 newModel) {
    if (newModel != currentModel) {
      setState(() {
        currentModel = newModel;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StudentInheritedWidget3(
      modelBindingState: this,
      child: widget.child,
    );
  }
}