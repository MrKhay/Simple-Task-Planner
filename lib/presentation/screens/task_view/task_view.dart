import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_task_app/core/constants/strings.dart';
import 'package:flutter_bloc_task_app/data/models/task_model/task_model.dart';
import 'package:flutter_bloc_task_app/logic/bloc/todo_bloc/todo_bloc.dart';

class TaskView extends StatelessWidget {
  final int todoIndex;
  const TaskView({Key? key, required this.todoIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todoData =
        context.select((TodoBloc bloc) => bloc.state?.todos[todoIndex]);
    final height = MediaQuery.of(context).size.height;
    final deviceTheme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: deviceTheme.colorScheme.background,
        title: Text(
          tasks,
          style: deviceTheme.textTheme.titleLarge,
        ),
      ),
      body: ListView.builder(
        itemCount: todoData?.tasks.length ?? 0,
        itemBuilder: (context, index) {
          var task = todoData!.tasks[index];

          return ListTile(
            leading: BlocBuilder<TodoBloc, TodoState?>(
              builder: (context, state) {
                Task task = state!.todos[todoIndex].tasks[index];
                return Checkbox(
                    value: task.isDone,
                    side: BorderSide(color: todoData.barColor),
                    fillColor: MaterialStatePropertyAll(todoData.barColor),
                    onChanged: (value) {
                      context.read<TodoBloc>().add(TodoEventToggleTaskIsDone(
                          isDone: !task.isDone,
                          todoIndex: todoIndex,
                          taskIndex: index));
                    });
              },
            ),
            title: Text(
              task.title,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          );
        },
      ),
    );
  }
}
