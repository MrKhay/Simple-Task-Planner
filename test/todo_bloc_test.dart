// import 'package:bloc_test/bloc_test.dart';
// import 'package:flutter_bloc_task_app/data/models/task_model/task_model.dart';
// import 'package:flutter_bloc_task_app/data/models/todo_model/todo_model.dart';
// import 'package:flutter_bloc_task_app/logic/bloc/todo_bloc/todo_bloc.dart';
// import 'package:flutter_test/flutter_test.dart';

// void main() {
//   blocTest<TodoBloc, TodoState?>(
//     'Test inital condition',
//     build: () => TodoBloc(),
//     verify: (bloc) => expect(bloc.state, null),
//   );

//   blocTest<TodoBloc, TodoState?>('Test load 1 notes',
//       build: () => TodoBloc(),
//       act: (bloc) {
//         bloc.add(
//           TodoEventAddNewTodo(
//             title: 'Todo 1',
//             timeCreated: DateTime(2023, 9, 7, 17, 30),
//             tasks: const [
//               Task(title: 'Task 1', isDone: false),
//             ],
//           ),
//         );
//       },
//       expect: () => [
//             TodoState(
//               todos: [
//                 Todo(
//                   title: 'Todo 1',
//                   timeCreated: DateTime(2023, 9, 7, 17, 30),
//                   tasks: const [
//                     Task(title: 'Task 1', isDone: false),
//                   ],
//                 ),
//               ],
//             ),
//           ]);

//   blocTest<TodoBloc, TodoState?>('Test load 2 notes',
//       build: () => TodoBloc(),
//       act: (bloc) {
//         bloc.add(
//           TodoEventAddNewTodo(
//             title: 'Todo 1',
//             timeCreated: DateTime(2023, 9, 7, 17, 30),
//             tasks: const [
//               Task(title: 'Task 1', isDone: false),
//             ],
//           ),
//         );
//         bloc.add(
//           TodoEventAddNewTodo(
//             title: 'Todo 1',
//             timeCreated: DateTime(2023, 9, 7, 17, 30),
//             tasks: const [
//               Task(title: 'Task 1', isDone: false),
//             ],
//           ),
//         );
//       },
//       expect: () => {
//             TodoState(todos: [
//               Todo(
//                 title: 'Todo 1',
//                 timeCreated: DateTime(2023, 9, 7, 17, 30),
//                 tasks: const [
//                   Task(title: 'Task 1', isDone: false),
//                 ],
//               ),
//             ]),
//             TodoState(todos: [
//               Todo(
//                 title: 'Todo 1',
//                 timeCreated: DateTime(2023, 9, 7, 17, 30),
//                 tasks: const [
//                   Task(title: 'Task 1', isDone: false),
//                 ],
//               ),
//               Todo(
//                 title: 'Todo 1',
//                 timeCreated: DateTime(2023, 9, 7, 17, 30),
//                 tasks: const [
//                   Task(title: 'Task 1', isDone: false),
//                 ],
//               ),
//             ]),
//           });

//   blocTest<TodoBloc, TodoState?>(
//       'Add 2 todos and test number of completed task',
//       build: () => TodoBloc(),
//       act: (bloc) {
//         bloc.add(
//           TodoEventAddNewTodo(
//             title: 'Todo 1',
//             timeCreated: DateTime(2023, 9, 7, 17, 30),
//             tasks: const [
//               Task(title: 'Task 1', isDone: true),
//             ],
//           ),
//         );
//         bloc.add(
//           TodoEventAddNewTodo(
//             title: 'Todo 1',
//             timeCreated: DateTime(2023, 9, 7, 17, 30),
//             tasks: const [
//               Task(title: 'Task 1', isDone: false),
//             ],
//           ),
//         );
//         bloc.add(const TodoEventGetNumberOfCompletedTask());
//       },
//       expect: () => {
//             TodoState(todos: [
//               Todo(
//                 title: 'Todo 1',
//                 timeCreated: DateTime(2023, 9, 7, 17, 30),
//                 tasks: const [
//                   Task(title: 'Task 1', isDone: true),
//                 ],
//               ),
//             ]),
//             TodoState(todos: [
//               Todo(
//                 title: 'Todo 1',
//                 timeCreated: DateTime(2023, 9, 7, 17, 30),
//                 tasks: const [
//                   Task(title: 'Task 1', isDone: true),
//                 ],
//               ),
//               Todo(
//                 title: 'Todo 1',
//                 timeCreated: DateTime(2023, 9, 7, 17, 30),
//                 tasks: const [
//                   Task(title: 'Task 1', isDone: false),
//                 ],
//               ),
//             ]),
//             TodoState(todos: [
//               Todo(
//                 title: 'Todo 1',
//                 timeCreated: DateTime(2023, 9, 7, 17, 30),
//                 tasks: const [
//                   Task(title: 'Task 1', isDone: true),
//                 ],
//               ),
//               Todo(
//                 title: 'Todo 1',
//                 timeCreated: DateTime(2023, 9, 7, 17, 30),
//                 tasks: const [
//                   Task(title: 'Task 1', isDone: false),
//                 ],
//               ),
//             ], completedTaskCount: 1),
//           });

//   blocTest<TodoBloc, TodoState?>(
//       'Add 2 todos and test number of uncompleted task',
//       build: () => TodoBloc(),
//       act: (bloc) {
//         bloc.add(
//           TodoEventAddNewTodo(
//             title: 'Todo 1',
//             timeCreated: DateTime(2023, 9, 7, 17, 30),
//             tasks: const [
//               Task(title: 'Task 1', isDone: true),
//             ],
//           ),
//         );
//         bloc.add(
//           TodoEventAddNewTodo(
//             title: 'Todo 1',
//             timeCreated: DateTime(2023, 9, 7, 17, 30),
//             tasks: const [
//               Task(title: 'Task 1', isDone: false),
//             ],
//           ),
//         );
//         bloc.add(const TodoEventGetNumberOfCompletedTask());
//       },
//       expect: () => {
//             TodoState(
//               todos: [
//                 Todo(
//                   title: 'Todo 1',
//                   timeCreated: DateTime(2023, 9, 7, 17, 30),
//                   tasks: const [
//                     Task(title: 'Task 1', isDone: true),
//                   ],
//                 ),
//               ],
//               unCompletedTaskCount: 0,
//               completedTaskCount: 0,
//             ),
//             TodoState(
//               todos: [
//                 Todo(
//                   title: 'Todo 1',
//                   timeCreated: DateTime(2023, 9, 7, 17, 30),
//                   tasks: const [
//                     Task(title: 'Task 1', isDone: true),
//                   ],
//                 ),
//                 Todo(
//                   title: 'Todo 1',
//                   timeCreated: DateTime(2023, 9, 7, 17, 30),
//                   tasks: const [
//                     Task(title: 'Task 1', isDone: false),
//                   ],
//                 ),
//               ],
//               unCompletedTaskCount: 0,
//               completedTaskCount: 0,
//             ),
//             TodoState(
//               todos: [
//                 Todo(
//                   title: 'Todo 1',
//                   timeCreated: DateTime(2023, 9, 7, 17, 30),
//                   tasks: const [
//                     Task(title: 'Task 1', isDone: true),
//                   ],
//                 ),
//                 Todo(
//                   title: 'Todo 1',
//                   timeCreated: DateTime(2023, 9, 7, 17, 30),
//                   tasks: const [
//                     Task(title: 'Task 1', isDone: false),
//                   ],
//                 ),
//               ],
//               unCompletedTaskCount: 0,
//               completedTaskCount: 1,
//             ),
//           });

//   blocTest(
//     'Add new todo then check if all todo\'s are completed ',
//     build: () => TodoBloc(),
//     act: (bloc) {
//       bloc.add(TodoEventAddNewTodo(
//           title: 'Yoo',
//           timeCreated: DateTime(0, 0, 000),
//           tasks: const [Task(title: 'YELLO', isDone: false)]));
//       bloc.add(const TodoEventToggleTaskIsDone(
//         taskIndex: 0,
//         todoIndex: 0,
//         isDone: true,
//       ));
//       bloc.add(const TodoEventToggleTodoIsCompleted());
//     },
//     expect: () => [
//       TodoState(
//         todos: [
//           Todo(
//             title: 'Yoo',
//             timeCreated: DateTime(0, 0, 000),
//             tasks: const [
//               Task(
//                 title: 'YELLO',
//                 isDone: false,
//               ),
//             ],
//             isCompleted: false,
//           ),
//         ],
//         completedTaskCount: 0,
//         unCompletedTaskCount: 0,
//       ),
//       TodoState(
//         todos: [
//           Todo(
//             title: 'Yoo',
//             timeCreated: DateTime(0, 0, 000),
//             tasks: const [
//               Task(
//                 title: 'YELLO',
//                 isDone: true,
//               ),
//             ],
//             isCompleted: false,
//           ),
//         ],
//         completedTaskCount: 0,
//         unCompletedTaskCount: 0,
//       ),
//       TodoState(
//         todos: [
//           Todo(
//             title: 'Yoo',
//             timeCreated: DateTime(0, 0, 000),
//             tasks: const [
//               Task(
//                 title: 'YELLO',
//                 isDone: true,
//               ),
//             ],
//             isCompleted: true,
//           ),
//         ],
//         completedTaskCount: 0,
//         unCompletedTaskCount: 0,
//       ),
//     ],
//   );
// }
