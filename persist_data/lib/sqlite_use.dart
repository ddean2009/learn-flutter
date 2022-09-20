import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class Student {
  final int id;
  final String name;
  final int age;

  const Student({
    required this.id,
    required this.name,
    required this.age,
  });

  // 将student转换成一个map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }

  @override
  String toString() {
    return 'Student{id: $id, name: $name, age: $age}';
  }
}

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  // 开启数据库
  final database = openDatabase(
    //数据库路径
    join(await getDatabasesPath(), 'student_database.db'),
    // 数据库第一次创建时调用的方法
    onCreate: (db, version) {
      // 创建table
      return db.execute(
        'CREATE TABLE students(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
      );
    },
    version: 1,
  );

  // 插入students
  Future<void> insertStudent(Student student) async {
    // get db
    final db = await database;

    // 插入数据
    await db.insert(
      'students',
      student.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // 获取students列表
  Future<List<Student>> students() async {
    final db = await database;

    // 查询students
    final List<Map<String, dynamic>> maps = await db.query('students');

    // 数据变化 convert List<Map<String, dynamic> into a List<Student>.
    return List.generate(maps.length, (i) {
      return Student(
        id: maps[i]['id'],
        name: maps[i]['name'],
        age: maps[i]['age'],
      );
    });
  }

  Future<void> updateStudent(Student student) async {
    final db = await database;

    //更新数据
    await db.update(
      'students',
      student.toMap(),
      where: 'id = ?',
      whereArgs: [student.id],
    );
  }

  Future<void> deleteStudent(int id) async {
    final db = await database;

    await db.delete(
      'dogs',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // 创建一个student
  var jack = const Student(
    id: 0,
    name: 'jack',
    age: 18
  );

  await insertStudent(jack);

  // 获取student列表
  print(await students());

  // 更新jack的age
  jack = Student(
    id: jack.id,
    name: jack.name,
    age: jack.age + 1,
  );
  await updateStudent(jack);

  // 再次获取students列表
  print(await students());

  // 删除数据
  await deleteStudent(jack.id);

  print(await students());
}

