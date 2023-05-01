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
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // init hive local storage
  final document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);

  await TodoDataProvider().initDataBase();
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Brightness brightness = MediaQuery.of(context).platformBrightness;
    // bool isDarkMode = brightness == Brightness.dark;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => TodoBloc(storageApi: TodoDataProvider())
              ..add(const TodoEventInitilize())),
        BlocProvider(create: (context) => TaskBloc()),
      ],
      child: MaterialApp(
        title: appTitle,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        initialRoute: AppRouter.home,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
