// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'todo_bloc.dart';

class TodoState extends Equatable {
  final List<Todo> todos;
  final int? completedTaskCount;
  final int? unCompletedTaskCount;
  const TodoState({
    required this.todos,
    this.completedTaskCount,
    this.unCompletedTaskCount,
  });

  @override
  String toString() =>
      'TodoState(todos: $todos, completedTaskCount: $completedTaskCount, unCompletedTaskCount: $unCompletedTaskCount)';

  @override
  List<Object?> get props => [completedTaskCount, unCompletedTaskCount, todos];
}

extension TodoEquality on Todo {
  bool checkEquality(Todo other) {
    return isCompleted == other.isCompleted &&
        title == other.title &&
        timeCreated == other.timeCreated &&
        tasks.length == other.tasks.length;
  }
}
