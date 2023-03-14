// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'todo_bloc.dart';

class TodoState extends Equatable {
  final List<Todo> todos;
  final int completedTaskCount;
  final int unCompletedTaskCount;
  const TodoState({
    required this.todos,
    this.completedTaskCount = 0,
    this.unCompletedTaskCount = 0,
  });

  @override
  String toString() =>
      'TodoState(todos: $todos, completedTaskCount: $completedTaskCount, unCompletedTaskCount: $unCompletedTaskCount)';

  @override
  List<Object?> get props => [todos, completedTaskCount, unCompletedTaskCount];
}

extension TodoEquality on List<Todo> {
  bool checkEquality(List<Todo> other) {
    for (int v = 0; v <= length; v++) {
      for (int i = 0; i <= this[v].tasks.length; i++) {
        if (this[v].tasks[i].isDone != other[v].tasks[i].isDone) {
          return false;
        } else if (this[v].tasks[i].title != other[v].tasks[i].title) {
          return false;
        }
      }
    }
    return length == other.length;
  }
}

  // @override
  // bool operator ==(covariant TodoState other) {
  //   return const DeepCollectionEquality().equals(todos, other.todos) &&
  //       other.completedTaskCount == completedTaskCount &&
  //       other.unCompletedTaskCount == unCompletedTaskCount;
  // }

  // @override
  // int get hashCode =>
  //     Object.hash(todos, completedTaskCount, unCompletedTaskCount);
