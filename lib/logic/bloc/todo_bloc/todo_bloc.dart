import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_task_app/core/extension/todo_data_extension.dart';
import 'package:flutter_bloc_task_app/data/models/task_model/task_model.dart';
import 'package:flutter_bloc_task_app/data/repositories/hive_repositories/hive_data_provider.dart';
import '../../../data/models/todo_model/todo_model.dart';

part 'todo_event.dart';
part 'todo_state.dart';

typedef GenerateRandomColor = Color Function();

class TodoBloc extends Bloc<TodoEvent, TodoState?> {
  final HiveStorageProtocol storageApi;

  TodoBloc({required this.storageApi, GenerateRandomColor? randomColorPicker})
      : super(null) {
    on<TodoEventInitilize>((event, emit) {
      var todoData = storageApi.readAllData() as List<Todo>;

      emit(TodoState(
        todos: todoData,
        completedTaskCount: todoData.numberOfCompletedTask(),
        unCompletedTaskCount: todoData.numberOfunCompletedTask(),
      ));
    });

    on<TodoEventAddNewTodo>((event, emit) {
      var randomColor = (randomColorPicker ?? generateRandomColor)();
      Todo todo = Todo(
          title: event.title,
          timeCreated: event.timeCreated,
          tasks: event.tasks,
          isCompleted: false,
          barColor: randomColor);
      storageApi.createData(todo);
      var todoData = storageApi.readAllData() as List<Todo>;

      emit(TodoState(
        todos: todoData,
        completedTaskCount: todoData.numberOfCompletedTask(),
        unCompletedTaskCount: todoData.numberOfunCompletedTask(),
      ));
    });

    on<TodoEventGetNumberOfCompletedTask>((event, emit) {
      var todoData = state?.todos ?? [];
      int completedTaskCount = 0;
      var unCompletedTaskCount = state?.unCompletedTaskCount ?? 0;
      // get number of completed task
      for (var i in todoData) {
        if (i.tasks.every((task) => task.isDone == true)) {
          completedTaskCount++;
        }
      }
      emit(TodoState(
        todos: todoData,
        completedTaskCount: completedTaskCount,
        unCompletedTaskCount: unCompletedTaskCount,
      ));
    });

    on<TodoEventGetNumberOfUncompletedTask>((event, emit) {
      var todoData = state?.todos ?? [];
      var completedTaskCount = state?.completedTaskCount ?? 0;
      var unCompletedTaskCount = 0;
      // get number of uncompleted task
      for (var i in todoData) {
        if (i.tasks.any((task) => task.isDone == false)) {
          unCompletedTaskCount++;
        }
      }
      emit(TodoState(
        todos: todoData,
        completedTaskCount: completedTaskCount,
        unCompletedTaskCount: unCompletedTaskCount,
      ));
    });

    on<TodoEventDeleteTodo>((event, emit) {
      storageApi.deleteData(event.todo);
      var todoData = storageApi.readAllData() as List<Todo>;

      emit(TodoState(
        todos: todoData,
        completedTaskCount: todoData.numberOfCompletedTask(),
        unCompletedTaskCount: todoData.numberOfunCompletedTask(),
      ));
    });

    on<TodoEventDeleteAllTodos>((event, emit) {
      storageApi.deleteAllData();
      var todoData = storageApi.readAllData() as List<Todo>;

      emit(TodoState(
        todos: todoData,
        unCompletedTaskCount: 0,
        completedTaskCount: 0,
      ));
    });

    on<TodoEventToggleTaskIsDone>((event, emit) {
      var todoData = storageApi.readAllData() as List<Todo>;

      var todo = todoData[event.todoIndex];
      var updatedTask = todo.tasks
          .mapIndexed((index, task) => index == event.taskIndex
              ? Task(title: task.title, isDone: event.isDone)
              : task)
          .toList();

          
      var todod = Todo(
          title: todo.title,
          timeCreated: todo.timeCreated,
          tasks: updatedTask,
          isCompleted: updatedTask.every((task) => task.isDone == true),
          barColor: todo.barColor);

      storageApi.updateData(todod, todo.key ?? event.todoIndex);

      // var todoData = (state?.todos ?? [])
      //     .mapIndexed((todoIndex, todo) => todoIndex == event.todoIndex
      //         ? todo.copyWith(
      //             tasks: todo.tasks
      //                 .mapIndexed((taskindex, task) =>
      //                     taskindex == event.taskIndex
      //                         ? task.copyWith(isDone: event.isDone)
      //                         : task)
      //                 .toList(),
      //           )
      //         : todo)
      //     .toList();
      var newTodoData = storageApi.readAllData() as List<Todo>;
      emit(TodoState(
        todos: newTodoData,
        unCompletedTaskCount: newTodoData.numberOfunCompletedTask(),
        completedTaskCount: newTodoData.numberOfCompletedTask(),
      ));
    });

    on<TodoEventToggleTodoIsCompleted>((event, emit) {
      var completedTaskCount = state?.completedTaskCount ?? 0;
      var unCompletedTaskCount = state?.unCompletedTaskCount ?? 0;

      // check if all tasks are complete
      var todoData = state?.todos ?? [];

      for (var i in todoData) {
        if (i.tasks.every((task) => task.isDone == true)) {
          todoData = todoData
              .mapIndexed((index, todo) => todo == i
                  ? Todo(
                      title: todo.title,
                      timeCreated: todo.timeCreated,
                      tasks: todo.tasks,
                      barColor: todo.barColor,
                      isCompleted: true)
                  : todo)
              .toList();
        } else {
          todoData = todoData
              .mapIndexed((index, todo) => todo == i
                  ? Todo(
                      title: todo.title,
                      timeCreated: todo.timeCreated,
                      tasks: todo.tasks,
                      barColor: todo.barColor,
                      isCompleted: false)
                  : todo)
              .toList();
        }
      }

      emit(TodoState(
        todos: [...todoData],
        unCompletedTaskCount: unCompletedTaskCount,
        completedTaskCount: completedTaskCount,
      ));
    });
  }
}

Color generateRandomColor() {
  const color = Colors.primaries;

  return color[Random().nextInt(color.length)].shade700;
}
