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
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.tasks),
      ),
      body: ListView.builder(
        itemCount: todoData?.tasks.length ?? 0,
        itemBuilder: (context, index) {
          var task = todoData!.tasks[index];

          return SizedBox(
            height: height * 0.05,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: BlocBuilder<TodoBloc, TodoState?>(
                    builder: (context, state) {
                      Task task = state!.todos[todoIndex].tasks[index];
                      return Checkbox(
                          value: task.isDone,
                          side: BorderSide(color: todoData.barColor),
                          fillColor:
                              MaterialStatePropertyAll(todoData.barColor),
                          onChanged: (value) {
                            context.read<TodoBloc>().add(
                                TodoEventToggleTaskIsDone(
                                    isDone: !task.isDone,
                                    todoIndex: todoIndex,
                                    taskIndex: index));
                          });
                    },
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        task.title,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        height: 1,
                        margin: const EdgeInsets.only(right: 20),
                        color: Colors.grey.withAlpha(40),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
