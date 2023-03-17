import 'package:flutter/material.dart';
import 'package:flutter_bloc_task_app/presentation/screens/todo_view/todo_view.dart';
import '../../core/exceptions/route_exception.dart';
import '../screens/add_new_todo_view/add_new_todo_view.dart';

class AppRouter {
  static const String home = '/';
  static const String addNewTodoView = 'add_new_todo_view';
  static const String task = 'task_view';

  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => const TodoView(),
        );
      case addNewTodoView:
        return MaterialPageRoute(
          builder: (_) => AddNewTodoTaskView(),
        );

      default:
        throw const RouteException('Route not found!');
    }
  }
}
