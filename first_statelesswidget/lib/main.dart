import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // 这是应用程序的根widget
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '第一个StatelessWidget',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const SafeArea(
        child: MyScaffold(),
      ),
    );
  }
}

class MyScaffold extends StatelessWidget {
  const MyScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      // 构建一个两行的column，一个是bar， 一个是具体的内容
      child: Column(
        children: [
          MyAppBar(
            title: Text(
              'StatelessWidget',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .primaryTextTheme
                  .headline6,
            ),
          ),
          const Expanded(
            child: Center(
              child: Text('这是一个Text组件!'),
            ),
          ),
        ],
      ),
    );
  }
}

class MyAppBar extends StatelessWidget {
  const MyAppBar({required this.title, Key? key}) : super(key: key);

  final Widget title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.0, // bar的高度
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(color: Colors.blue[500]),
      // 按Row来进行布局
      child: Row(
        children: [
          const IconButton(
            icon: Icon(Icons.menu),
            tooltip: '导航菜单',
            onPressed: null, // 目前不可点击
          ),
          // Expanded组件，用于填充所有可用的空间
          Expanded(
            child: title,
          ),
          const IconButton(
            icon: Icon(Icons.search),
            tooltip: '搜索',
            onPressed: null,
          ),
        ],
      ),
    );
  }
}
