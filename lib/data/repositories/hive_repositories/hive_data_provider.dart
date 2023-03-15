import 'package:flutter_bloc_task_app/data/models/todo_model/todo_model.dart';
import 'package:hive/hive.dart';

abstract class HiveStorageProtocol {
  // init database
  Future<Box<Object>> initDataBase();
  // creat a new recode
  void createData(Todo todo);
  // read all
  List<Object> readAllData();

  // update a recode
  void updateData(Todo todo, int key);

  // delete data
  void deleteData(Todo todo);
}
