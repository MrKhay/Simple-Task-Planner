import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_task_app/core/extension/todo_data_extension.dart';
import 'package:flutter_bloc_task_app/logic/bloc/task_bloc/task_bloc.dart';
import 'package:flutter_bloc_task_app/logic/bloc/todo_bloc/todo_bloc.dart';
import 'package:flutter_bloc_task_app/presentation/router/app_router.dart';
import '../../../data/models/task_model/task_model.dart';
import '../../../data/models/todo_model/todo_model.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../task_view/task_view.dart';

class TodoView extends StatelessWidget {
  const TodoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todoData = context.watch<TodoBloc>().state;
    return WillPopScope(
      onWillPop: () async {
        context.read<TaskBloc>().add(const TaskEventRemoveAll());
        return true;
      },
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRouter.addNewTodoView,
              );
            },
            child: const Icon(Icons.add),
          ),
          body: CustomScrollView(
            slivers: [
              SliverAppBar.large(
                floating: true,
                pinned: true,
                snap: true,
                centerTitle: false,
                backgroundColor: Colors.amber,
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.black,
                    ),
                  ),
                  PopupMenuButton(
                    splashRadius: 6,
                    itemBuilder: (context) {
                      return const [
                        PopupMenuItem(child: Text('Hello')),
                        PopupMenuItem(child: Text('Hello')),
                        PopupMenuItem(child: Text('Hello')),
                      ];
                    },
                    child: const Icon(
                      Icons.info_outline,
                      color: Colors.black,
                    ),
                  )
                ],
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  expandedTitleScale: 1.4,
                  title: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: 'TODAY ',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: DateTime.now().formateDay(),
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontWeight: FontWeight.w400))
                  ])),
                  background: Container(
                    color: Colors.grey,
                    child: Column(children: [
                      Flexible(
                        child: Container(
                          alignment: Alignment.center,
                          color: Colors.blueAccent,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Tasks ☆',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Completed ${todoData?.completedTaskCount ?? 0} ◐ Uncompleted ${todoData?.unCompletedTaskCount ?? 0}',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ],
                          ),
                        ),
                      )
                    ]),
                  ),
                ),
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                /// Body
                SingleChildScrollView(
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var todo = todoData?.todos[index] ?? [] as Todo;

                        return GestureDetector(
                          child: todoTile(todo),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TaskView(
                                          todoIndex: index,
                                        )));
                          },
                        );
                      },
                      itemCount: todoData?.todos.length ?? 0,
                    ),
                  ),
                )
              ]))
            ],
          )),
    );
  }
}

Widget todoTile(Todo todo) {
  return ListTile(
    leading: todo.isCompleted
        ? Container(
            width: 10,
            height: 10,
            color: todo.barColor,
          )
        : CircularStepProgressIndicator(
            totalSteps: todo.tasks.length,
            currentStep: todo.tasks.numberOfCompletedTask(),
            stepSize: 4,
            selectedColor: todo.barColor,
            unselectedColor: todo.barColor.withAlpha(40),
            padding: 0,
            width: 30,
            height: 30,
            selectedStepSize: 5,
            roundedCap: (_, __) => false,
          ),
    title: Text(
      todo.title,
      style: const TextStyle(color: Colors.black),
    ),
    subtitle: Text(
      todo.timeCreated.formateDateTime(),
    ),
  );
}
