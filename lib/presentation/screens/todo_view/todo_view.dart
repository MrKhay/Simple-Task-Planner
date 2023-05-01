import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_task_app/core/extension/todo_data_extension.dart';
import 'package:flutter_bloc_task_app/logic/bloc/todo_bloc/todo_bloc.dart';
import 'package:flutter_bloc_task_app/presentation/router/app_router.dart';
import 'package:flutter_bloc_task_app/presentation/screens/todo_view/widgets/customcheck_box.dart';
import '../../../data/models/todo_model/todo_model.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../task_view/task_view.dart';

class TodoView extends StatelessWidget {
  const TodoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todoData = context.watch<TodoBloc>().state;
    final deviceTheme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: deviceTheme.colorScheme.background,
        title: Row(
          children: [
            Text(
              'TODAY',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '  ${DateTime.now().formateDay()}',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 5),
                Icon(
                  Icons.arrow_drop_down_sharp,
                  color: deviceTheme.colorScheme.shadow,
                )
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                context.read<TodoBloc>().add(const TodoEventDeleteAllTodos());
              },
              icon: Icon(
                Icons.delete_forever,
                color: deviceTheme.colorScheme.onBackground,
              )),
          PopupMenuButton(
            icon: const Icon(
              Icons.info_outlined,
            ),
            position: PopupMenuPosition.under,
            elevation: 0.5,
            color: Colors.white.withOpacity(0.7),
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  child: Text('Task\'s info'),
                ),
                PopupMenuItem(
                    child: Text(
                        'Completed: ${todoData?.completedTaskCount ?? 0}')),
                PopupMenuItem(
                    child: Text(
                        'Uncompleted: ${todoData?.unCompletedTaskCount ?? 0}')),
              ];
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: deviceTheme.colorScheme.primary,
        onPressed: () {
          Navigator.pushNamed(
            context,
            AppRouter.addNewTodoView,
          );
        },
        child: Icon(
          Icons.add,
          color: deviceTheme.colorScheme.onBackground,
        ),
      ),
      backgroundColor: deviceTheme.colorScheme.background,
      body: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          var todo = todoData?.todos[index] ?? [] as Todo;
          return GestureDetector(
            child: todoTile(todo, context),
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
    );
  }
}

Widget todoTile(Todo todo, BuildContext context) {
  return Dismissible(
    direction: DismissDirection.endToStart,
    key: UniqueKey(),
    secondaryBackground: Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20),
      color: Colors.red,
      child: const Icon(
        Icons.delete,
        color: Colors.white,
      ),
    ),
    background: const Icon(
      Icons.delete,
      color: Colors.black,
    ),
    onDismissed: (_) {
      context.read<TodoBloc>().add(TodoEventDeleteTodo(
            todo: todo,
          ));
    },
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 5,
            decoration: BoxDecoration(
                color: todo.isCompleted ? Colors.transparent : todo.barColor,
                borderRadius: BorderRadius.circular(20)),
          ),
          const SizedBox(width: 5),
          todo.isCompleted
              ? CustomCheckBox(
                  isChecked: true,
                  onChange: () {},
                  size: 25,
                  iconSize: 18,
                  checkIcon: const Icon(Icons.check_rounded),
                  selectedColor: Colors.blue,
                  selectedIconColor: Colors.white,
                  borderColor: Colors.white,
                )
              : CircularStepProgressIndicator(
                  totalSteps: todo.tasks.length,
                  currentStep: todo.tasks.numberOfCompletedTask(),
                  stepSize: 4,
                  selectedColor: todo.barColor,
                  unselectedColor: todo.barColor.withAlpha(40),
                  padding: 0,
                  width: 25,
                  height: 25,
                  selectedStepSize: 5,
                  roundedCap: (_, __) => false,
                ),
        ],
      ),
      title: Text(
        todo.title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Text(
        todo.timeCreated.formateDateTime(),
        style: Theme.of(context)
            .textTheme
            .labelMedium
            ?.copyWith(color: Colors.grey),
      ),
    ),
  );
}
