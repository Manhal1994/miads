import 'package:maids/data/models/task.dart';

import '../../data/remote/dto/basic_response.dart';
import '../repositories/task_repository.dart';

class DeleteTaskUseCase{
  final TaskRepository _taskRepository;
  DeleteTaskUseCase(this._taskRepository);

  Future<BasicResponse> call(TaskModel taskModel) async {
    return _taskRepository.deleteTask(taskModel: taskModel);

  }
}