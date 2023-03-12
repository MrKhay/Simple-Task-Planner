// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'task_bloc.dart';

@immutable
class TaskState {
  final Task task;

  const TaskState({required this.task});

  @override
  String toString() => 'TaskState(task: $task)';

  @override
  bool operator ==(covariant TaskState other) {
    if (identical(this, other)) return true;

    return other.task == task;
  }

  @override
  int get hashCode => task.hashCode;
}
