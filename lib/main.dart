import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_task_app/logic/bloc/task_bloc/task_bloc.dart';

import 'core/constants/strings.dart';
import 'core/themes/app_theme.dart';
import 'data/models/task_model.dart';
import 'logic/bloc/todo_bloc/todo_bloc.dart';
import 'logic/debug/app_bloc_observer.dart';
import 'presentation/router/app_router.dart';

void main() {
  Bloc.observer = AppBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TodoBloc()
            ..add(
              TodoEventAddNewTodo(
                title: 'Hello hello',
                timeCreated: DateTime(2023, 9, 7, 17, 30),
                tasks:  [
                  Task(title: 'Task 2', isDone: false),
                ],
              ),
            ),
        ),
        BlocProvider(create: (context) => TaskBloc()),
      ],
      child: MaterialApp(
        title: Strings.appTitle,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: AppRouter.home,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
