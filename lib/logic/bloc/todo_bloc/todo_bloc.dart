import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_bloc_task_app/data/models/task_model.dart';
import '../../../data/models/todo_model.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState?> {
  List<Todo> todoData;
  TodoBloc({required this.todoData}) : super(null) {
    on<TodoEventAddNewTodo>((event, emit) {
      final Todo todo = Todo(
        title: event.title,
        timeCreated: event.timeCreated,
        tasks: event.tasks,
      );

      todoData.add(todo);
      final List<Todo> todos = todoData;

      emit(TodoState(todos: todos));
    });

    on<TodoEventGetNumberOfCompletedTask>((event, emit) {
      final todos = todoData;

      // get number of completed task
      int completedTaskCount = 0;
      for (var i in todos) {
        if (i.tasks.every((task) => task.isDone == true)) {
          completedTaskCount++;
        }
      }

      emit(TodoState(
        todos: todos,
        completedTaskCount: completedTaskCount,
      ));
    });

    on<TodoEventGetNumberOfUncompletedTask>((event, emit) {
      final todos = todoData;

      // get number of completed task
      int unCompletedTaskCount = 0;
      for (var i in todos) {
        if (i.tasks.every((task) => task.isDone == false)) {
          unCompletedTaskCount++;
        }
      }

      emit(TodoState(
        todos: todos,
        unCompletedTaskCount: unCompletedTaskCount,
      ));
    });

    on<TodoEventDeleteTodo>((event, emit) {
      final todos = state?.todos ?? [];

      todos.remove(event.todo);
      emit(TodoState(todos: todos));
    });

    on<TodoEventDeleteAllTodos>((event, emit) {
      final todos = state?.todos ?? [];
      todos.clear();
// remove delete all todos
      emit(TodoState(todos: todos));
    });
  }
}
