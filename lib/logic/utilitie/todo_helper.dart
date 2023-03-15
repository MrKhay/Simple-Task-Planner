import 'package:flutter_bloc_task_app/data/models/todo_model/todo_model.dart';

// get number of completed task
int getNumberOfCompleteTodo(Iterable<Todo> todos) {
  int count = 0;
  for (var i in todos) {
    if (i.isCompleted) {
      count++;
    }
  }
  return count;
}

// get number of unCompleted task
int getNumberOfUncompleteTodo(Iterable<Todo> todos) {
  int count = 0;
  for (var i in todos) {
    if (i.isCompleted == false) {
      count++;
    }
  }
  return count;
}

// add to new task to list of todo
// Todo addNewTask({required Task task}) {
  
// }

// delete todo

// add new todo