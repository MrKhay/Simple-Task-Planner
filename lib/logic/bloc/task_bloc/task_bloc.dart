import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../../data/models/task_model/task_model.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState?> {
  TaskBloc() : super(null) {
    on<TaskEventAddNewTask>((event, emit) {
      var task = Task(title: event.title, isDone: false);

      var tanksList = state?.task ?? [];

      emit(
        TaskState(task: [...tanksList, task]),
      );
    });

    on<TaskEventRemoveTask>((event, emit) {
      var tasks = state?.task ?? [];

      tasks = tasks.where((task) => task != event.task).toList();

      emit(
        TaskState(task: [...tasks]),
      );
    });

    on<TaskEventRemoveAll>((event, emit) {
      emit(
        const TaskState(task: []),
      );
    });
  }
}
