part of 'add_task_bloc.dart';

@immutable
abstract class EditTaskState {}

 class AddTaskInitial extends EditTaskState {}
 class AddTaskLoading extends EditTaskState {}
 class AddTaskSuccess extends EditTaskState {
  final TaskModel taskModel;
  AddTaskSuccess(this.taskModel);
 }
 class AddTaskError extends EditTaskState {
   final String message;
   AddTaskError(this.message);
 }

