// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'task_bloc.dart';

@immutable
abstract class TaskEvent {
  const TaskEvent();
}

@immutable
class TaskEvetDone extends TaskEvent {
  
  const TaskEvetDone();
}

@immutable
class TaskEvenNotDone extends TaskEvent {
  const TaskEvenNotDone();
}

@immutable
class TaskEventAddNewTask extends TaskEvent {
  final String title;
  const TaskEventAddNewTask({
    required this.title,
  });
}
