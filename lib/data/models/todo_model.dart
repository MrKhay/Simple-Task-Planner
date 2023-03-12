// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

import 'package:flutter_bloc_task_app/data/models/task_model.dart';

@immutable
class Todo {
  final String title;
  final DateTime timeCreated;
  bool isCompleted;
  final Iterable<Task> tasks;
  Todo({
    this.isCompleted = false,
    required this.title,
    required this.timeCreated,
    required this.tasks,
  }) {
    isCompleted = tasks.every((element) => element.isDone == true);
  }

  Todo copyWith({
    String? title,
    DateTime? timeCreated,
    bool? isCompleted,
    Iterable<Task>? tasks,
  }) {
    return Todo(
      title: title ?? this.title,
      timeCreated: timeCreated ?? this.timeCreated,
      isCompleted: isCompleted ?? this.isCompleted,
      tasks: tasks ?? this.tasks,
    );
  }

  @override
  bool operator ==(covariant Todo other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.timeCreated == timeCreated &&
        other.isCompleted == isCompleted &&
        other.tasks == tasks;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        timeCreated.hashCode ^
        isCompleted.hashCode ^
        tasks.hashCode;
  }

  @override
  String toString() {
    return 'TODO(title: $title, timeCreated: $timeCreated, isCompleted: $isCompleted, tasks: $tasks)';
  }
}
