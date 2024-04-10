part of 'get_tasks_bloc.dart';

@immutable
abstract class GetTasksState {}

 class GetTasksInitial extends GetTasksState {}
 class GetTasksLoading extends GetTasksState {}
 class GetTasksSuccess extends GetTasksState {
   final PageData<TaskModel> taskEntity;
   GetTasksSuccess(this.taskEntity);
 }
 class GetTasksError extends GetTasksState {
  final String message;
  GetTasksError({required this.message});
 }

