import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:maids/data/local/local_data_source.dart';
import 'package:maids/data/local/local_data_source_impl.dart';
import 'package:maids/data/repositories/auth_repository_impl.dart';
import 'package:maids/data/repositories/task_repository_impl.dart';
import 'package:maids/domain/repositories/auth_repository.dart';
import 'package:maids/domain/repositories/task_repository.dart';
import 'package:maids/domain/usecases/create_task_use_case.dart';
import 'package:maids/domain/usecases/delete_task_use_case.dart';
import 'package:maids/domain/usecases/get_tasks_use_case.dart';
import 'package:maids/domain/usecases/login_use_case.dart';
import 'package:maids/domain/usecases/update_task_use_case.dart';
import 'package:maids/presntation/add_edit_task/bloc/add_task_bloc.dart';
import 'package:maids/presntation/authenication/bloc/login/login_bloc.dart';
import 'package:maids/presntation/authenication/bloc/validate/validate_bloc.dart';
import 'package:maids/presntation/tasks/bloc/delete_task/delete_task_bloc.dart';
import 'package:maids/presntation/tasks/bloc/get_tasks/get_tasks_bloc.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'core/constants.dart';
import 'data/local/app_database.dart';
import 'data/remote/dio_remote_data_source_impl.dart';
import 'data/remote/remote_data_source.dart';

final sl = GetIt.instance;
Future<void> initializeDependencies() async {

  // Dio
  sl.registerSingleton<Dio>(Dio(BaseOptions(baseUrl: BASE_URL))..interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      error: true,
      compact: false,
      maxWidth: 120)));

  // data source
  sl.registerLazySingleton<RemoteDataSource>(() => DioRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<LocalDataSource>(() => LocalDatabaseImpl(sl()));


  // Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl(sl(), sl()));

  //database
  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerSingleton<AppDatabase>(database);


  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => CreateTaskUseCase(sl()));
  sl.registerLazySingleton(() => GetTasksUseCases(sl()));
  sl.registerLazySingleton(() => UpdateTaskUseCase(sl()));
  sl.registerLazySingleton(() => DeleteTaskUseCase(sl()));





  // bloc
  sl.registerFactory(() => LoginBloc(sl()));
  sl.registerFactory(() => EditTaskBloc(sl(), sl()));
  sl.registerFactory(() => GetTasksBloc(sl()));
  sl.registerFactory(() => DeleteTaskBloc(sl()));
  sl.registerFactory(() => ValidateBloc());






}
