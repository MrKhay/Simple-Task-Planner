// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:flutter_bloc_task_app/data/models/task_model/task_model.dart';

part 'todo_model.g.dart';

@immutable
@HiveType(typeId: 0)
class Todo extends Equatable with HiveObjectMixin {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final DateTime timeCreated;
  @HiveField(2)
  final bool isCompleted;
  @HiveField(3)
  final Color barColor;
  @HiveField(4)
  final List<Task> tasks;

  Todo({
    required this.isCompleted,
    required this.title,
    required this.timeCreated,
    required this.tasks,
    required this.barColor,
  });

  Todo copyWith({
    String? title,
    DateTime? timeCreated,
    bool? isCompleted,
    Color? barColor,
    List<Task>? tasks,
  }) {
    return Todo(
      title: title ?? this.title,
      timeCreated: timeCreated ?? this.timeCreated,
      isCompleted: isCompleted ?? this.isCompleted,
      barColor: barColor ?? this.barColor,
      tasks: tasks ?? this.tasks,
    );
  }

  @override
  List<Object> get props {
    return [
      title,
      timeCreated,
      isCompleted,
      barColor,
      tasks,
    ];
  }

  @override
  bool get stringify => true;
}
