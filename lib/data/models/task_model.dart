// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

@immutable
class Task {
  final String title;
  final bool isDone;
  const Task({
    required this.title,
    required this.isDone,
  });

  Task copyWith({
    String? title,
    bool? isDone,
  }) {
    return Task(
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
    );
  }

  @override
  String toString() => 'Task(title: $title, isDone: $isDone)';
}
