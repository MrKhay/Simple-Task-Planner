// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class Task extends Equatable {
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

  @override
  List<Object?> get props => [title, isDone];
}
