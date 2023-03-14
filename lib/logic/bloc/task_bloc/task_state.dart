// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'task_bloc.dart';

@immutable
class TaskState {
  final List<Task> task;

  const TaskState({required this.task});

  @override
  String toString() => 'TaskState(task: $task)';

  @override
  bool operator ==(covariant TaskState other) {
    return listEquals(task, other.task);
  }

  @override
  int get hashCode => task.hashCode;
}
