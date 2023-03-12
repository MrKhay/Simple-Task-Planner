import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc_task_app/data/models/task_model.dart';
import 'package:flutter_bloc_task_app/data/models/todo_model.dart';
import 'package:flutter_bloc_task_app/logic/bloc/todo_bloc/todo_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

List<Todo> mockedTodoEmpty = [];
List<Todo> mockedTodo = [
  Todo(
    title: 'Todo 2',
    timeCreated: DateTime(2023, 9, 7, 17, 30),
    tasks: const [
      Task(title: 'Task 1', isDone: false),
    ],
  ),
];

List<Todo> expectedMockedData1 = [
  Todo(
    title: 'Todo 2',
    timeCreated: DateTime(2023, 9, 7, 17, 30),
    tasks: const [
      Task(title: 'Task 1', isDone: false),
    ],
  ),
  Todo(
    title: 'Todo 1',
    timeCreated: DateTime(2023, 9, 7, 17, 30),
    tasks: const [
      Task(title: 'Task 1', isDone: false),
    ],
  ),
];

List<Todo> expectedMockedData2 = [
  Todo(
    title: 'Todo 2',
    timeCreated: DateTime(2023, 9, 7, 17, 30),
    tasks: const [
      Task(title: 'Task 1', isDone: false),
    ],
  ),
  Todo(
    title: 'Todo 1',
    timeCreated: DateTime(2023, 9, 7, 17, 30),
    tasks: const [
      Task(title: 'Task 1', isDone: false),
    ],
  ),
  Todo(
    title: 'Todo 1',
    timeCreated: DateTime(2023, 9, 7, 17, 30),
    tasks: const [
      Task(title: 'Task 1', isDone: false),
    ],
  ),
];

void main() {
  blocTest<TodoBloc, TodoState?>(
    'Test inital condition',
    build: () => TodoBloc(todoData: []),
    verify: (bloc) => expect(bloc.state, null),
  );

  blocTest<TodoBloc, TodoState?>('Test load 1 notes',
      build: () => TodoBloc(todoData: mockedTodoEmpty),
      act: (bloc) {
        bloc.add(
          TodoEventAddNewTodo(
            title: 'Todo 1',
            timeCreated: DateTime(2023, 9, 7, 17, 30),
            tasks: const [
              Task(title: 'Task 1', isDone: false),
            ],
          ),
        );
      },
      expect: () => [
            TodoState(todos: [
              Todo(
                title: 'Todo 1',
                timeCreated: DateTime(2023, 9, 7, 17, 30),
                tasks: const [
                  Task(title: 'Task 1', isDone: false),
                ],
              ),
            ]),
          ]);

  blocTest<TodoBloc, TodoState?>('Test load 2 notes',
      build: () => TodoBloc(todoData: mockedTodo),
      act: (bloc) {
        bloc.add(
          TodoEventAddNewTodo(
            title: 'Todo 1',
            timeCreated: DateTime(2023, 9, 7, 17, 30),
            tasks: const [
              Task(title: 'Task 1', isDone: false),
            ],
          ),
        );
        bloc.add(
          TodoEventAddNewTodo(
            title: 'Todo 1',
            timeCreated: DateTime(2023, 9, 7, 17, 30),
            tasks: const [
              Task(title: 'Task 1', isDone: false),
            ],
          ),
        );
      },
      expect: () => {
            TodoState(todos: [
              Todo(
                title: 'Todo 2',
                timeCreated: DateTime(2023, 9, 7, 17, 30),
                tasks: const [
                  Task(title: 'Task 1', isDone: false),
                ],
              ),
              Todo(
                title: 'Todo 1',
                timeCreated: DateTime(2023, 9, 7, 17, 30),
                tasks: const [
                  Task(title: 'Task 1', isDone: false),
                ],
              ),
              Todo(
                title: 'Todo 1',
                timeCreated: DateTime(2023, 9, 7, 17, 30),
                tasks: const [
                  Task(title: 'Task 1', isDone: false),
                ],
              ),
            ]),
          });

  blocTest<TodoBloc, TodoState?>('Test number of completed task in 0 todos',
      build: () => TodoBloc(todoData: []),
      act: (bloc) {
        bloc.add(TodoEventGetNumberOfCompletedTask());
      },
      expect: () => {const TodoState(todos: [], completedTaskCount: 0)});

  blocTest<TodoBloc, TodoState?>('Test number of completed task in 2 todos',
      build: () => TodoBloc(todoData: [
            Todo(
              title: 'Todo 2',
              timeCreated: DateTime(2023, 9, 7, 17, 30),
              tasks: const [
                Task(title: 'Task 1', isDone: true),
              ],
            ),
            Todo(
              title: 'Todo 2',
              timeCreated: DateTime(2023, 9, 7, 17, 30),
              tasks: const [
                Task(title: 'Task 1', isDone: true),
              ],
            ),
          ]),
      act: (bloc) {
        bloc.add(TodoEventGetNumberOfCompletedTask());
      },
      expect: () => {
            TodoState(
              todos: [
                Todo(
                  title: 'Todo 2',
                  timeCreated: DateTime(2023, 9, 7, 17, 30),
                  tasks: const [
                    Task(title: 'Task 1', isDone: true),
                  ],
                ),
                Todo(
                  title: 'Todo 2',
                  timeCreated: DateTime(2023, 9, 7, 17, 30),
                  tasks: const [
                    Task(title: 'Task 1', isDone: true),
                  ],
                ),
              ],
              completedTaskCount: 2,
            )
          });

  blocTest<TodoBloc, TodoState?>('Test number of uncompleted task in 0 todos',
      build: () => TodoBloc(todoData: []),
      act: (bloc) {
        bloc.add(TodoEventGetNumberOfUncompletedTask());
      },
      expect: () => {const TodoState(todos: [], unCompletedTaskCount: 0)});

  blocTest<TodoBloc, TodoState?>('Test number of uncompleted task in 2 todos',
      build: () => TodoBloc(todoData: [
            Todo(
              title: 'Todo 2',
              timeCreated: DateTime(2023, 9, 7, 17, 30),
              tasks: const [
                Task(title: 'Task 1', isDone: false),
              ],
            ),
            Todo(
              title: 'Todo 2',
              timeCreated: DateTime(2023, 9, 7, 17, 30),
              tasks: const [
                Task(title: 'Task 1', isDone: false),
              ],
            ),
          ]),
      act: (bloc) {
        bloc.add(TodoEventGetNumberOfUncompletedTask());
      },
      expect: () => {
            TodoState(
              todos: [
                Todo(
                  title: 'Todo 2',
                  timeCreated: DateTime(2023, 9, 7, 17, 30),
                  tasks: const [
                    Task(title: 'Task 1', isDone: false),
                  ],
                ),
                Todo(
                  title: 'Todo 2',
                  timeCreated: DateTime(2023, 9, 7, 17, 30),
                  tasks: const [
                    Task(title: 'Task 1', isDone: false),
                  ],
                ),
              ],
              unCompletedTaskCount: 2,
            )
          });

  blocTest<TodoBloc, TodoState?>(
      'Test number of completed and uncompleted task in 2 todos',
      build: () => TodoBloc(todoData: [
            Todo(
              title: 'Todo 2',
              timeCreated: DateTime(2023, 9, 7, 17, 30),
              tasks: const [
                Task(title: 'Task 1', isDone: true),
                Task(title: 'Task 1', isDone: true),
                Task(title: 'Task 1', isDone: true),
              ],
            ),
            Todo(
              title: 'Todo 2',
              timeCreated: DateTime(2023, 9, 7, 17, 30),
              tasks: const [
                Task(title: 'Task 1', isDone: true),
                Task(title: 'Task 1', isDone: true),
                Task(title: 'Task 1', isDone: false),
              ],
            ),
          ]),
      act: (bloc) {
        bloc.add(TodoEventGetNumberOfCompletedTask());
        bloc.add(TodoEventGetNumberOfUncompletedTask());
      },
      expect: () => {
            TodoState(todos: [
              Todo(
                title: 'Todo 2',
                timeCreated: DateTime(2023, 9, 7, 17, 30),
                tasks: const [
                  Task(title: 'Task 1', isDone: true),
                  Task(title: 'Task 1', isDone: true),
                  Task(title: 'Task 1', isDone: true),
                ],
              ),
              Todo(
                title: 'Todo 2',
                timeCreated: DateTime(2023, 9, 7, 17, 30),
                tasks: const [
                  Task(title: 'Task 1', isDone: true),
                  Task(title: 'Task 1', isDone: true),
                  Task(title: 'Task 1', isDone: false),
                ],
              ),
            ], completedTaskCount: 1),
            TodoState(todos: [
              Todo(
                title: 'Todo 2',
                timeCreated: DateTime(2023, 9, 7, 17, 30),
                tasks: const [
                  Task(title: 'Task 1', isDone: true),
                  Task(title: 'Task 1', isDone: true),
                  Task(title: 'Task 1', isDone: true),
                ],
              ),
              Todo(
                title: 'Todo 2',
                timeCreated: DateTime(2023, 9, 7, 17, 30),
                tasks: const [
                  Task(title: 'Task 1', isDone: true),
                  Task(title: 'Task 1', isDone: true),
                  Task(title: 'Task 1', isDone: false),
                ],
              ),
            ], unCompletedTaskCount: 0),
          });
}
