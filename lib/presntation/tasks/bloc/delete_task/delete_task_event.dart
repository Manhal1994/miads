part of 'delete_task_bloc.dart';

@immutable
abstract class DeleteTaskEvent {}

class DeleteTask extends DeleteTaskEvent{
  final TaskModel taskModel;
  DeleteTask(this.taskModel);
}
