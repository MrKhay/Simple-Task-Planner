// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'task_bloc.dart';

@immutable
abstract class TaskEvent {
  const TaskEvent();
}

@immutable
class TaskEventAddNewTask extends TaskEvent {
  final String title;
  const TaskEventAddNewTask({
    required this.title,
  });
}

@immutable
class TaskEventRemoveTask extends TaskEvent {
  final Task task;
  const TaskEventRemoveTask({
    required this.task,
  });
}

@immutable
class TaskEventRemoveAll extends TaskEvent {
  const TaskEventRemoveAll();
}
