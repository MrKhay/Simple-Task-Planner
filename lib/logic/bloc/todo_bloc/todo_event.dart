// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent {
  const TodoEvent();
}

@immutable
class TodoEventGetNumberOfCompletedTask extends TodoEvent {}

@immutable
class TodoEventGetNumberOfUncompletedTask extends TodoEvent {}

@immutable
class TodoEventAddNewTodo extends TodoEvent {
  final String title;
  final DateTime timeCreated;
  final List<Task> tasks;
  const TodoEventAddNewTodo({
    required this.title,
    required this.timeCreated,
    required this.tasks,
  });
}

@immutable
class TodoEventDeleteTodo extends TodoEvent {
  final Todo todo;
  const TodoEventDeleteTodo({
    required this.todo,
  });
}

@immutable
class TodoEventDeleteAllTodos extends TodoEvent {
  const TodoEventDeleteAllTodos();
}
