import 'package:flutter/material.dart';

class OffstageApp extends StatefulWidget{
  @override
  State<OffstageApp> createState() => _OffstageAppState();
}

class _OffstageAppState extends State<OffstageApp>{
  final GlobalKey _key = GlobalKey();
  bool _offstage = true;

  Size _getSizedBoxSize() {
    final RenderBox renderBox =
    _key.currentContext!.findRenderObject()! as RenderBox;
    return renderBox.size;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Offstage(
          offstage: _offstage,
          child: SizedBox(
            key: _key,
            width: 150.0,
            height: 150.0,
            child: Container(
              color: Colors.red,
            ),
          ),
        ),
        Text('SizedBox is offstage: $_offstage'),
        ElevatedButton(
          child: const Text('切换offstage'),
          onPressed: () {
            setState(() {
              _offstage = !_offstage;
            });
          },
        ),
        if (_offstage)
          ElevatedButton(
              child: const Text('检测SizedBox大小'),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content:
                    Text('SizedBox is ${_getSizedBoxSize()}'),
                  ),
                );
              }),
      ],
    );
  }
}

