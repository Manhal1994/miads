import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maids/data/local/local_data_source.dart';
import 'package:maids/presntation/add_edit_task/bloc/add_task_bloc.dart';
import 'package:maids/presntation/authenication/bloc/login/login_bloc.dart';
import 'package:maids/presntation/authenication/bloc/validate/validate_bloc.dart';
import 'package:maids/presntation/authenication/login_page.dart';
import 'package:maids/presntation/tasks/bloc/delete_task/delete_task_bloc.dart';
import 'package:maids/presntation/tasks/bloc/get_tasks/get_tasks_bloc.dart';
import 'package:maids/presntation/tasks/tasks_page.dart';

import 'inject_container.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(create: (context) => sl()),
        BlocProvider<EditTaskBloc>(create: (context) => sl()),
        BlocProvider<GetTasksBloc>(create: (context) => sl()),
        BlocProvider<DeleteTaskBloc>(create: (context) => sl()),
        BlocProvider<ValidateBloc>(create: (context) => sl())
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: ScreenUtilInit(
              designSize: const Size(430, 932),
              builder: (context, child) {
                return sl<LocalDataSource>().getToken() != null
                    ? const TasksPage()
                    : const LoginPage();
              })),
    );
  }
}
