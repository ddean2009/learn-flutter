import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

void main() {
  runApp(const MaterialApp(home: AnimateDragApp()));
}

class AnimateDragApp extends StatelessWidget {
  const AnimateDragApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const DraggableHead(
        child: Image(image: AssetImage('images/head.jpg'),
          width: 100,
          height: 100,)
      ),
    );
  }
}

class DraggableHead extends StatefulWidget {
  const DraggableHead({required this.child, super.key});

  final Widget child;

  @override
  State<DraggableHead> createState() => _DraggableHeadState();
}

class _DraggableHeadState extends State<DraggableHead>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  Alignment _animateAlign = Alignment.center;

  late Animation<Alignment> _animation;

  void _runAnimation() {
    _animation = _controller.drive(
      AlignmentTween(
        begin: _animateAlign,
        end: Alignment.center,
      ),
    );

    const spring = SpringDescription(
      mass: 30,
      stiffness: 1,
      damping: 1,
    );

    final simulation = SpringSimulation(spring, 0, 1, -1);

    _controller.animateWith(simulation);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    _controller.addListener(() {
      setState(() {
        _animateAlign = _animation.value;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onPanDown: (details) {
        _controller.stop();
      },
      onPanUpdate: (details) {
        setState(() {
          _animateAlign += Alignment(
            details.delta.dx / (size.width / 2),
            details.delta.dy / (size.height / 2),
          );
        });
      },
      onPanEnd: (details) {
        _runAnimation();
      },
      child: Align(
        alignment: _animateAlign,
        child: Card(
          child: widget.child,
        ),
      ),
    );
  }
}