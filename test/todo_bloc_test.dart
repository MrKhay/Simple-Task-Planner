import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_task_app/data/models/task_model/task_model.dart';
import 'package:flutter_bloc_task_app/data/models/todo_model/todo_model.dart';
import 'package:flutter_bloc_task_app/data/repositories/hive_repositories/hive_data_provider.dart';
import 'package:flutter_bloc_task_app/logic/bloc/todo_bloc/todo_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

var mockedData = [
  Todo(
      title: 'Khay',
      timeCreated: DateTime(0),
      isCompleted: false,
      tasks: const [
        Task(title: 'Task 1', isDone: false),
      ],
      barColor: Colors.black),
  Todo(
      title: 'Khay',
      timeCreated: DateTime(0),
      isCompleted: false,
      tasks: const [
        Task(title: 'Task 1', isDone: false),
      ],
      barColor: Colors.black),
];

class HiveMockedData implements HiveStorageProtocol {
  @override
  void createData(Todo todo) {
    mockedData.add(todo);
  }

  @override
  void deleteData(Todo todo) {
    mockedData.remove(todo);
  }

  @override
  Future<Box<Object>> initDataBase() {
    return Future.delayed(Duration.zero);
  }

  @override
  List<Object> readAllData() {
    return mockedData;
  }

  @override
  void updateData(Todo todo, int key) {
    mockedData[key] = todo;
  }

  @override
  void deleteAllData() {
    // TODO: implement deleteAllData
  }
}

void main() {
  blocTest<TodoBloc, TodoState?>(
    'Test inital condition',
    build: () => TodoBloc(storageApi: HiveMockedData()),
    verify: (bloc) => expect(bloc.state, null),
  );

  blocTest<TodoBloc, TodoState?>('Test add new todo',
      build: () => TodoBloc(
            storageApi: HiveMockedData(),
            randomColorPicker: () => Colors.red,
          ),
      act: (bloc) {
        bloc.add(
          TodoEventAddNewTodo(
            title: 'Todo 1',
            timeCreated: DateTime(0),
            tasks: const [
              Task(title: 'Task 1', isDone: false),
            ],
          ),
        );
      },
      expect: () => [
            TodoState(
              todos: [
                Todo(
                    title: 'Khay',
                    timeCreated: DateTime(0),
                    isCompleted: false,
                    tasks: const [
                      Task(title: 'Task 1', isDone: false),
                    ],
                    barColor: Colors.black),
                Todo(
                    title: 'Khay',
                    timeCreated: DateTime(0),
                    isCompleted: false,
                    tasks: const [
                      Task(title: 'Task 1', isDone: false),
                    ],
                    barColor: Colors.black),
                Todo(
                  title: 'Todo 1',
                  timeCreated: DateTime(0),
                  isCompleted: false,
                  barColor: Colors.red,
                  tasks: const [
                    Task(title: 'Task 1', isDone: false),
                  ],
                ),
              ],
              completedTaskCount: 0,
              unCompletedTaskCount: 3,
            ),
          ]);

  blocTest<TodoBloc, TodoState?>('Test remove todo',
      build: () => TodoBloc(
            storageApi: HiveMockedData(),
            randomColorPicker: () => Colors.red,
          ),
      act: (bloc) {
        bloc.add(
          TodoEventDeleteTodo(
            todo: Todo(
                title: 'Khay',
                timeCreated: DateTime(0),
                isCompleted: false,
                tasks: const [
                  Task(title: 'Task 1', isDone: false),
                ],
                barColor: Colors.black),
          ),
        );
      },
      expect: () => [
            TodoState(
              todos: [
                Todo(
                    title: 'Khay',
                    timeCreated: DateTime(0),
                    isCompleted: false,
                    tasks: const [
                      Task(title: 'Task 1', isDone: false),
                    ],
                    barColor: Colors.black),
              ],
              completedTaskCount: 0,
              unCompletedTaskCount: 1,
            ),
          ]);
  blocTest<TodoBloc, TodoState?>(
    'Test toggle task is done',
    build: () => TodoBloc(
      storageApi: HiveMockedData(),
      randomColorPicker: () => Colors.red,
    ),
    act: (bloc) {
      bloc.add(const TodoEventToggleTaskIsDone(
          taskIndex: 0, todoIndex: 1, isDone: true));
    },
    expect: () => [
      TodoState(
        todos: [
          Todo(
              title: 'Khay',
              timeCreated: DateTime(0),
              tasks: const [
                Task(title: 'Task 1', isDone: false),
              ],
              barColor: Colors.black,
              isCompleted: false),
          Todo(
              title: 'Khay',
              timeCreated: DateTime(0),
              tasks: const [
                Task(
                  title: 'Task 1',
                  isDone: true,
                ),
              ],
              barColor: Colors.black,
              isCompleted: true),
        ],
        completedTaskCount: 1,
        unCompletedTaskCount: 1,
      ),
    ],
  );
}
