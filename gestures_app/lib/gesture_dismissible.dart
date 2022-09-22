import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  final items = List<String>.generate(10, (i) => '动物 ${i + 1}');

  Future<bool> confirmResult(DismissDirection direction) async {
    if(direction == DismissDirection.endToStart){
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    const title = 'Dismissing Items';

    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(title),
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Dismissible(
              key: Key(item),
              onDismissed: (direction) {
                setState(() {
                  items.removeAt(index);
                });
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('$item 被删除了')));
              },
              background: Container(color: Colors.red),
              confirmDismiss:confirmResult,
              child: ListTile(
                title: Text(item),
              ),
            );
          },
        ),
      ),
    );
  }
}

