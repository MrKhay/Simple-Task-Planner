import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_task_app/data/data_providers/todo_data_provider/todo_data_provider.dart';
import 'package:flutter_bloc_task_app/logic/bloc/task_bloc/task_bloc.dart';
import 'core/constants/strings.dart';
import 'core/themes/app_theme.dart';
import 'logic/bloc/todo_bloc/todo_bloc.dart';
import 'logic/debug/app_bloc_observer.dart';
import 'presentation/router/app_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // init hive local storage
  await Hive.initFlutter();
  await TodoDataProvider().initDataBase();
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
            create: (context) => TodoBloc(storageApi: TodoDataProvider())
              ..add(const TodoEventInitilize())),
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
