import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_task_app/core/constants/strings.dart';
import 'package:flutter_bloc_task_app/data/models/task_model.dart';
import 'package:flutter_bloc_task_app/logic/bloc/todo_bloc/todo_bloc.dart';
import 'package:collection/collection.dart';
import '../../../data/models/todo_model.dart';

class TaskView extends StatelessWidget {
  final int todoIndex;
  const TaskView({Key? key, required this.todoIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final taskData =
    //     context.watch<TodoBloc>().state?.todos[todoIndex].tasks ?? [];
    final taskData = context
        .select((TodoBloc bloc) => bloc.state?.todos[todoIndex].tasks ?? []);
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.task),
      ),
      body: ListView.builder(
        itemCount: taskData.length,
        itemBuilder: (context, index) {
          var task = taskData[index];

          return ListTile(
            title: Text(task.title),
            leading: BlocBuilder<TodoBloc, TodoState?>(
              builder: (context, state) {
                Task task = state!.todos[todoIndex].tasks[index];
                return Checkbox(
                    value: task.isDone,
                    onChanged: (value) {
                      context.read<TodoBloc>().add(TodoEventToggleTaskIsDone(
                          isDone: !task.isDone,
                          todoIndex: todoIndex,
                          taskIndex: index));
                    });
              },
            ),
          );
        },
      ),
    );
  }
}
