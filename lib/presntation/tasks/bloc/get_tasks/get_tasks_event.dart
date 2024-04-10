part of 'get_tasks_bloc.dart';

@immutable
abstract class GetTasksEvent {}

class GetTasks extends GetTasksEvent{
  final int skip;
  final int limit;

  GetTasks({required this.limit, required this.skip});

}
