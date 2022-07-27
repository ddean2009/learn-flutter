
import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Image.network(
            'https://img-blog.csdnimg.cn/bb5b19255ab6406cb6bdc467ecc40462.webp',
          ),
        ),
      ),
    );
  }
}