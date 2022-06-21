import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _changeIndex() {
    setState(() {
      _counter = (_counter+1) % 4;
      print(_counter);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: IndexedStack(
          index: _counter,
          children: [
            widgetOne(),
            widgetTwo(),
            widgetThree(),
            widgetFour(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _changeIndex,
        tooltip: 'change index',
        child: const Icon(Icons.arrow_back),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget widgetOne() {
    return SizedBox(
      width: 100,
      height: 100,
      child: Container(
        color: Colors.yellow,
      ),
    );
  }

  Widget widgetTwo() {
    return SizedBox(
      width: 200,
      height: 200,
      child: Container(
        color: Colors.blue,
      ),
    );
  }

  Widget widgetThree() {
    return SizedBox(
      width: 300,
      height: 300,
      child: Container(
        color: Colors.black,
      ),
    );
  }

  Widget widgetFour() {
    return SizedBox(
      width: 400,
      height: 400,
      child: Container(
        color: Colors.red,
      ),
    );
  }
}
