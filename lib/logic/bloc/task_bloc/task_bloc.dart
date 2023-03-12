import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../../data/models/task_model.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState?> {
  TaskBloc() : super(null) {
    on<TaskEventAddNewTask>((event, emit) {
      final title = event.title;
      final task = Task(title: title, isDone: false);

      emit(TaskState(task: task));
    });
  }
}


