import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_task_app/data/models/task_model/task_model.dart';
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
    final taskController = useTextEditingController(text: 'Title');
    final titileController = useTextEditingController(text: 'Task');
    FocusNode titleFocusNode = FocusNode();
    FocusNode taskFocusNode = FocusNode();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        context.read<TaskBloc>().add(const TaskEventRemoveAll());
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text(Strings.task),
          ),
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// task [Text Widget]
                Text(
                  Strings.activityTitle,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 5),
                Container(
                  height: height * 0.065,
                  width: width,
                  child: TextField(
                    controller: titileController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: Strings.inputActivityTitle,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  Strings.addTasks,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 7),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: height * 0.065,
                      width: width * 0.7,
                      child: TextField(
                        controller: taskController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                          hintText: Strings.inputTasks,
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
                            context.read<TaskBloc>().add(TaskEventAddNewTask(
                                  title: taskController.text,
                                ));
                            taskController.clear();
                          },
                          child: const Center(
                            child: Icon(
                              Icons.add,
                              size: 27,
                              color: Colors.white,
                            ),
                          )),
                    )
                  ],
                ),

                const SizedBox(height: 10),

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
                                  color: Colors.black26,
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
                        color: Colors.blue,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        onPressed: () {
                          context
                              .read<TaskBloc>()
                              .add(const TaskEventRemoveAll());
                          Navigator.pop(context);
                        },
                        child: Text(
                          Strings.cancle,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black38),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      flex: 2,
                      child: MaterialButton(
                        height: height * 0.07,
                        color: Colors.amber,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        onPressed: () {
                          context.read<TodoBloc>().add(TodoEventAddNewTodo(
                              title: titileController.text,
                              timeCreated: DateTime.now(),
                              tasks:
                                  context.read<TaskBloc>().state?.task ?? []));
                        },
                        child: Text(
                          Strings.add,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue),
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
