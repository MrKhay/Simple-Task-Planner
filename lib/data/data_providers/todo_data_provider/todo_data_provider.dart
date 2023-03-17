import 'package:flutter_bloc_task_app/data/repositories/hive_repositories/hive_data_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/constants/strings.dart';
import '../../models/task_model/task_model.dart';
import '../../models/todo_model/todo_model.dart';

class TodoDataProvider extends HiveStorageProtocol {
  @override
  Future<Box<Todo>> initDataBase() async {
    // open data box
    Hive.registerAdapter(TodoAdapter());
    Hive.registerAdapter(TaskAdapter());
    return await Hive.openBox<Todo>('todoData');
  }

  @override
  void createData(Todo todo) async {
    final box = Hive.box<Todo>('todoData');
    await box.add(todo);
  }

  @override
  deleteData(Todo todo) async {
    final box = Hive.box<Todo>('todoData');
    await box.delete(todo.key);
  }

  @override
  List<Todo> readAllData() {
    final box = Hive.box<Todo>('todoData');
    return box.values.toList();
  }

  @override
  void updateData(Todo todo, int key) async {
    final box = Hive.box<Todo>('todoData');
    await box.put(key, todo);
  }

  @override
  void deleteAllData() {
    final box = Hive.box<Todo>('todoData');
    box.clear();
  }
}
