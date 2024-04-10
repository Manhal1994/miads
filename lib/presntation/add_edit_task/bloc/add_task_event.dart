part of 'add_task_bloc.dart';

@immutable
abstract class EditTaskEvent {}

class CreateTask extends EditTaskEvent{
  final String name;
  CreateTask({required this.name});
}

class UpdateTask extends EditTaskEvent{
  final TaskModel taskModel;
  UpdateTask({required this.taskModel});
}