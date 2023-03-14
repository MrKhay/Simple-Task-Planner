// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_bloc_task_app/data/models/task_model.dart';

@immutable
class Todo extends Equatable {
  final String title;
  final DateTime timeCreated;
  bool isCompleted;
  final List<Task> tasks;
  Todo({
    this.isCompleted = false,
    required this.title,
    required this.timeCreated,
    required this.tasks,
  });

  Todo copyWith({
    String? title,
    DateTime? timeCreated,
    bool? isCompleted,
    List<Task>? tasks,
  }) {
    return Todo(
      title: title ?? this.title,
      timeCreated: timeCreated ?? this.timeCreated,
      isCompleted: isCompleted ?? this.isCompleted,
      tasks: tasks ?? this.tasks,
    );
  }

  @override
  String toString() {
    return 'TODO(title: $title, timeCreated: $timeCreated, isCompleted: $isCompleted, tasks: $tasks)';
  }

  @override
  List<Object?> get props => [
        title,
        timeCreated,
        tasks,
        isCompleted,
      ];
}
