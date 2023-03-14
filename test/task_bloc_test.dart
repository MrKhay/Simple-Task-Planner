import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc_task_app/data/models/task_model.dart';
import 'package:flutter_bloc_task_app/logic/bloc/task_bloc/task_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  blocTest<TaskBloc, TaskState?>(
    'Test init state',
    build: () => TaskBloc(),
    verify: (bloc) => expect(bloc.state, null),
  );

  blocTest<TaskBloc, TaskState?>(
    'Test add new task',
    build: () => TaskBloc(),
    act: (bloc) => bloc.add(const TaskEventAddNewTask(title: 'Hello')),
    expect: () => [
      TaskState(task: [Task(title: 'Hello', isDone: false)])
    ],
  );

  blocTest<TaskBloc, TaskState?>(
    'Test add 2 new task',
    build: () => TaskBloc(),
    act: (bloc) {
      bloc.add(const TaskEventAddNewTask(title: 'Hello 1'));
      bloc.add(const TaskEventAddNewTask(title: 'Hello 2'));
    },
    expect: () => const [
      TaskState(task: [
        Task(title: 'Hello 1', isDone: false),
      ]),
      TaskState(task: [
        Task(title: 'Hello 1', isDone: false),
        Task(title: 'Hello 2', isDone: false),
      ]),
    ],
  );

  blocTest<TaskBloc, TaskState?>(
    'Test add 2 new task and remove 1',
    build: () => TaskBloc(),
    act: (bloc) {
      bloc.add(const TaskEventAddNewTask(title: 'Hello 1'));
      bloc.add(const TaskEventAddNewTask(title: 'Hello 2'));
      bloc.add(const TaskEventRemoveTask(
        task: Task(title: 'Hello 2', isDone: false),
      ));
    },
    expect: () => const [
      TaskState(task: [
        Task(title: 'Hello 1', isDone: false),
      ]),
      TaskState(task: [
        Task(title: 'Hello 1', isDone: false),
        Task(title: 'Hello 2', isDone: false),
      ]),
      TaskState(task: [
        Task(title: 'Hello 1', isDone: false),
      ]),
    ],
  );

  blocTest<TaskBloc, TaskState?>(
    'Test add 3 new task and remove all',
    build: () => TaskBloc(),
    act: (bloc) {
      bloc.add(const TaskEventAddNewTask(title: 'Hello 1'));
      bloc.add(const TaskEventAddNewTask(title: 'Hello 2'));
      bloc.add(const TaskEventAddNewTask(title: 'Hello 3'));
      bloc.add(const TaskEventRemoveAll());
    },
    expect: () => const [
      TaskState(task: [
        Task(title: 'Hello 1', isDone: false),
      ]),
      TaskState(task: [
        Task(title: 'Hello 1', isDone: false),
        Task(title: 'Hello 2', isDone: false),
      ]),
      TaskState(task: [
        Task(title: 'Hello 1', isDone: false),
        Task(title: 'Hello 2', isDone: false),
        Task(title: 'Hello 3', isDone: false),
      ]),
      TaskState(task: []),
    ],
  );
}
