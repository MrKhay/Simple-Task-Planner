import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_task_app/core/constants/strings.dart';
import 'package:flutter_bloc_task_app/logic/bloc/task_bloc/task_bloc.dart';
import 'package:flutter_bloc_task_app/logic/bloc/todo_bloc/todo_bloc.dart';
import 'package:flutter_bloc_task_app/presentation/router/app_router.dart';
import 'package:intl/intl.dart';
import '../../../data/models/todo_model.dart';
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
          title: const Text(Strings.todo),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              AppRouter.addNewTodoView,
            );
            // context.read<TodoBloc>().add(TodoEventAddNewTodo(
            //     title: 'Hello',
            //     timeCreated: DateTime(2023, 9, 7, 17, 30),
            //     tasks: []));
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
    title: Text(
      todo.title,
      style: const TextStyle(color: Colors.black),
    ),
    subtitle: Text(
      todo.timeCreated.formateDateTime(),
    ),
  );
}

extension FormatDateTime on DateTime {
  String formateDateTime() =>
      DateFormat('yyy-MM-dd h:mm a', 'en_US').format(this);
}
