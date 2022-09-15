import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Todos> fetchTodos() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));

  if (response.statusCode == 200) {
    return Todos.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load todos');
  }
}

class Todos {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  const Todos({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  factory Todos.fromJson(Map<String, dynamic> json) {
    return Todos(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      completed: json['completed'],
    );
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Todos> futureTodos;

  @override
  void initState() {
    super.initState();
    futureTodos = fetchTodos();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Todos>(
            future: futureTodos,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.title);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}