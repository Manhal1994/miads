part of 'delete_task_bloc.dart';

@immutable
abstract class DeleteTaskState {}

class DeleteTaskInitial extends DeleteTaskState {}
class DeleteTaskLoading extends DeleteTaskState {}
class DeleteTaskSuccess extends DeleteTaskState {}
class DeleteTaskError extends DeleteTaskState {}

