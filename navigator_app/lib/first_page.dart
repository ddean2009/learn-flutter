
import 'package:flutter/material.dart';
import 'package:navigator_app/second_page.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Page'),
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const SecondPage();
          }));
        },
        child: Image.network(
          'https://img-blog.csdnimg.cn/262d104f04684f24a7b79a51ed6a5eb7.webp',
        ),
      ),
    );
  }
}
