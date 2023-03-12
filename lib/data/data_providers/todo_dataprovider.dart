import 'package:flutter_bloc_task_app/data/models/task_model.dart';
import 'package:flutter_bloc_task_app/data/models/todo_model.dart';

final List<Todo> todoDataProvider = [
  Todo(
    title: 'Todo 1',
    timeCreated: DateTime(2023, 9, 7, 17, 30),
    tasks: const [
      Task(title: 'Task 1', isDone: false),
    ],
  )
];
