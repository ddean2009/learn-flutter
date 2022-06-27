import 'package:flutter/material.dart';

class FlowApp extends StatefulWidget {
  const FlowApp({Key? key}) : super(key: key);

  @override
  State<FlowApp> createState() => _FlowAppState();
}

class _FlowAppState extends State<FlowApp>
    with SingleTickerProviderStateMixin {
  late AnimationController buttonAnimation;

  final List<IconData> buttonItems = <IconData>[
    Icons.home,
    Icons.ac_unit,
    Icons.adb,
    Icons.airplanemode_active,
    Icons.account_box_rounded,
  ];


  @override
  void initState() {
    super.initState();
    buttonAnimation = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
  }

  Widget flowButtonItem(IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: IconButton(
        icon: Icon(icon,
          size: 50,
            color: Colors.blue
        ),
          onPressed: () {
            buttonAnimation.status == AnimationStatus.completed
                ? buttonAnimation.reverse()
                : buttonAnimation.forward();
          },

      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: FlowButtonDelegate(buttonAnimation: buttonAnimation),
      children:
      buttonItems.map<Widget>((IconData icon) => flowButtonItem(icon)).toList(),
    );
  }
}

class FlowButtonDelegate extends FlowDelegate {
  FlowButtonDelegate({required this.buttonAnimation})
      : super(repaint: buttonAnimation);

  final Animation<double> buttonAnimation;

  @override
  bool shouldRepaint(FlowButtonDelegate oldDelegate) {
    return buttonAnimation != oldDelegate.buttonAnimation;
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    double dy = 0.0;
    for (int i = 0; i < context.childCount; ++i) {
      dy = context.getChildSize(i)!.height * i;
      context.paintChild(
        i,
        transform: Matrix4.translationValues(
          0,
          dy * buttonAnimation.value,
          0,
        ),
      );
    }
  }
}

