import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_task_app/data/models/task_model/task_model.dart';
import 'package:flutter_bloc_task_app/logic/bloc/task_bloc/task_bloc.dart';
import 'package:flutter_bloc_task_app/logic/bloc/todo_bloc/todo_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../core/constants/strings.dart';

class AddNewTodoTaskView extends HookWidget {
  const AddNewTodoTaskView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var taskController = useTextEditingController(text: 'Task');

    return WillPopScope(
      onWillPop: () async {
        context.read<TaskBloc>().add(const TaskEventRemoveAll());
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text(Strings.task),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                /// task [Text Widget]
                const Text('Task'),

                TextField(
                  controller: taskController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        context.read<TodoBloc>().add(TodoEventAddNewTodo(
                            title: 'Khay',
                            timeCreated: DateTime.now(),
                            tasks: context.read<TaskBloc>().state?.task ?? []));
                      },
                      color: Colors.blue,
                      padding: const EdgeInsets.all(16),
                      child: const Text('Add new todo'),
                    ),
                    MaterialButton(
                      onPressed: () {
                        context.read<TaskBloc>().add(TaskEventAddNewTask(
                              title: taskController.text,
                            ));
                      },
                      color: Colors.blue,
                      padding: const EdgeInsets.all(16),
                      child: const Text('Add new event'),
                    ),
                  ],
                ),
                Expanded(
                  child: BlocBuilder<TaskBloc, TaskState?>(
                    builder: (context, state) {
                      List<Task> tasksData = state?.task ?? [];

                      return ListView.builder(
                        itemCount: tasksData.length,
                        itemBuilder: (context, index) {
                          var data = tasksData[index];
                          return Text(
                            data.title,
                            style: const TextStyle(color: Colors.red),
                          );
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          )),
    );
  }
}
