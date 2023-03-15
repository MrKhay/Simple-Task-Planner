import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_task_app/core/extension/todo_data_extension.dart';

import 'package:flutter_bloc_task_app/logic/bloc/task_bloc/task_bloc.dart';
import 'package:flutter_bloc_task_app/logic/bloc/todo_bloc/todo_bloc.dart';
import 'package:flutter_bloc_task_app/presentation/router/app_router.dart';
import 'package:intl/intl.dart';
import '../../../data/models/todo_model/todo_model.dart';
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
        appBar: AppBar(
          title: Text(DateTime.now().formateDay()),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {},
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              AppRouter.addNewTodoView,
            );
          },
          child: const Icon(Icons.add),
        ),
        body: ListView.builder(
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
    );
  }
}

Widget todoTile(Todo todo) {
  return ListTile(
    leading: Container(
      width: 10,
      height: 10,
      color: todo.barColor,
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
