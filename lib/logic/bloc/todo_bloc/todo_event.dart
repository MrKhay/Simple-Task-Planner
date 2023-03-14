// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent {
  const TodoEvent();
}

@immutable
class TodoEventGetNumberOfCompletedTask extends TodoEvent {
  const TodoEventGetNumberOfCompletedTask();
}

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

@immutable
class TodoEventToggleTaskIsDone extends TodoEvent {
  final int todoIndex;
  final int taskIndex;
  final bool isDone;
  const TodoEventToggleTaskIsDone({
    required this.taskIndex,
    required this.todoIndex,
    required this.isDone,
  });
}

@immutable
class TodoEventToggleTodoIsCompleted extends TodoEvent {
  const TodoEventToggleTodoIsCompleted();
}
