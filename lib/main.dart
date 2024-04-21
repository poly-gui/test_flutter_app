import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test_flutter_app/todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _todos = <Todo>[];
  final _textFieldController = TextEditingController();
  final _rand = Random.secure();

  void _addTodo() {
    setState(() {
      _todos.add(Todo(
        id: _rand.nextInt(4294967295),
        content: _textFieldController.value.text,
      ));
    });
  }

  void _markTodoAsDone(int i) {
    setState(() {
      _todos.removeAt(i);
    });
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: TextField(
                  controller: _textFieldController,
                ),
              ),
              FilledButton(
                onPressed: _addTodo,
                child: const Text("Add todo"),
              )
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, i) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_todos[i].content),
                  const SizedBox(width: 8),
                  OutlinedButton(
                    onPressed: () {
                      _markTodoAsDone(i);
                    },
                    child: const Text("Done"),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
