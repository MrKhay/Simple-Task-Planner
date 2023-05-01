import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_task_app/core/extension/extensions.dart';
import 'package:flutter_bloc_task_app/logic/bloc/task_bloc/task_bloc.dart';
import 'package:flutter_bloc_task_app/logic/bloc/todo_bloc/todo_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../core/constants/strings.dart';

class AddNewTodoTaskView extends HookWidget {
  AddNewTodoTaskView({super.key});

  final List<String> intervals = [
    'No Reminder',
    '5 Minutes',
    '15 Minutes',
    '1 Hour'
  ];

  @override
  Widget build(BuildContext context) {
    final taskController = useTextEditingController(text: 'Title'.debugMode());
    final titileController = useTextEditingController(text: 'Task'.debugMode());

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final deviceTheme = Theme.of(context);
    var taskData = context.watch<TaskBloc>().state?.task ?? [];
    return WillPopScope(
      onWillPop: () async {
        context.read<TaskBloc>().add(const TaskEventRemoveAll());
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: deviceTheme.colorScheme.background,
            title: Text(
              newTasks,
              style: deviceTheme.textTheme.titleLarge,
            ),
          ),
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// task [Text Widget]
                Text(
                  activityTitle,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: height * 0.065,
                  width: width,
                  child: TextField(
                    controller: titileController,
                    style: deviceTheme.textTheme.bodyLarge,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: inputActivityTitle,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  addTasks,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: height * 0.065,
                      width: width * 0.7,
                      child: TextField(
                        controller: taskController,
                        keyboardType: TextInputType.text,
                        style: deviceTheme.textTheme.bodyLarge,
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                          hintText: inputTasks,
                        ),
                      ),
                    ),
                    Container(
                      height: height * 0.06,
                      width: 60,
                      clipBehavior: Clip.hardEdge,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      child: MaterialButton(
                          color: Colors.blueGrey[300],
                          onPressed: () {
                            if (taskController.text.isNotEmpty) {
                              context.read<TaskBloc>().add(TaskEventAddNewTask(
                                    title: taskController.text,
                                  ));
                              taskController.clear();
                            }
                          },
                          child: Center(
                            child: Icon(
                              Icons.add,
                              size: 27,
                              color: deviceTheme.colorScheme.onBackground,
                            ),
                          )),
                    )
                  ],
                ),

                const SizedBox(height: 24),

                BlocBuilder<TaskBloc, TaskState?>(builder: (context, state) {
                  return Wrap(
                    spacing: 10.7,
                    children: List.generate(
                        state?.task.length ?? 0,
                        (index) => state?.task.isEmpty == true
                            ? const SizedBox(
                                width: 1,
                              )
                            : Chip(
                                deleteIcon: const Icon(
                                  Icons.cancel_rounded,
                                  color: Colors.grey,
                                ),
                                onDeleted: () {
                                  context.read<TaskBloc>().add(
                                      TaskEventRemoveTask(
                                          task: state.task[index]));
                                },
                                label: Text(
                                  state!.task[index].title,
                                  style: Theme.of(context).textTheme.labelLarge,
                                ))),
                  );
                }),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: 1,
                      child: MaterialButton(
                        height: height * 0.07,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        splashColor: deviceTheme.primaryColor.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(color: Colors.grey)),
                        onPressed: () {
                          context
                              .read<TaskBloc>()
                              .add(const TaskEventRemoveAll());
                          Navigator.pop(context);
                        },
                        child: Text(
                          cancle,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      flex: 2,
                      child: MaterialButton(
                        height: height * 0.07,
                        color: deviceTheme.colorScheme.primary,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        onPressed: () {
                          if (titileController.text.isEmpty ||
                              taskData.isEmpty) {
                            return;
                          }
                          context.read<TodoBloc>().add(TodoEventAddNewTodo(
                              title: titileController.text,
                              timeCreated: DateTime.now(),
                              tasks: taskData));
                          context
                              .read<TaskBloc>()
                              .add(const TaskEventRemoveAll());
                          Navigator.pop(context);
                        },
                        child: Text(
                          add,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
