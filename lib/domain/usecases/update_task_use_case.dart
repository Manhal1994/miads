import 'package:maids/data/models/task.dart';

import '../../data/remote/dto/basic_response.dart';
import '../repositories/task_repository.dart';

class UpdateTaskUseCase{
  final TaskRepository _taskRepository;
  UpdateTaskUseCase(this._taskRepository);

  Future<BasicResponse> call({required TaskModel taskModel}){
    return _taskRepository.updateTask(taskModel: taskModel);
  }
}