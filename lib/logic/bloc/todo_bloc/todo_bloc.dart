import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc_task_app/data/models/task_model.dart';
import '../../../data/models/todo_model.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState?> {
  TodoBloc() : super(null) {
    on<TodoEventAddNewTodo>((event, emit) {
      Todo todo = Todo(
        title: event.title,
        timeCreated: event.timeCreated,
        tasks: event.tasks,
      );

      var todoData = state?.todos ?? [];
      var completedTaskCount = state?.completedTaskCount ?? 0;
      var unCompletedTaskCount = state?.unCompletedTaskCount ?? 0;

      emit(TodoState(
        todos: [...todoData, todo],
        completedTaskCount: completedTaskCount,
        unCompletedTaskCount: unCompletedTaskCount,
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
        todos: [...todoData],
        completedTaskCount: completedTaskCount,
        unCompletedTaskCount: unCompletedTaskCount,
      ));
    });

    on<TodoEventGetNumberOfUncompletedTask>((event, emit) {
      var todoData = state?.todos ?? [];
      var completedTaskCount = state?.completedTaskCount ?? 0;
      var unCompletedTaskCount = 0;
      // get number of completed task

      for (var i in todoData) {
        if (i.tasks.every((task) => task.isDone == false)) {
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
      var todoData = state?.todos ?? [];
      var completedTaskCount = state?.completedTaskCount ?? 0;
      var unCompletedTaskCount = state?.unCompletedTaskCount ?? 0;

      todoData.remove(event.todo);

      emit(TodoState(
        todos: [...todoData],
        unCompletedTaskCount: unCompletedTaskCount,
        completedTaskCount: completedTaskCount,
      ));
    });

    on<TodoEventDeleteAllTodos>((event, emit) {
      var todoData = state?.todos ?? [];

      todoData.clear();
      emit(const TodoState(
        todos: [],
        unCompletedTaskCount: 0,
        completedTaskCount: 0,
      ));
    });

    on<TodoEventToggleTaskIsDone>((event, emit) {
      var completedTaskCount = state?.completedTaskCount ?? 0;
      var unCompletedTaskCount = state?.unCompletedTaskCount ?? 0;

      var todoData = (state?.todos ?? [])
          .mapIndexed((todoIndex, todo) => todoIndex == event.todoIndex
              ? todo.copyWith(
                  tasks: todo.tasks
                      .mapIndexed((taskindex, task) =>
                          taskindex == event.taskIndex
                              ? task.copyWith(isDone: event.isDone)
                              : task)
                      .toList(),
                )
              : todo)
          .toList();

      emit(TodoState(
        todos: [...todoData],
        unCompletedTaskCount: unCompletedTaskCount,
        completedTaskCount: completedTaskCount,
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
