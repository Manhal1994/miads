import 'package:maids/data/remote/dto/basic_response.dart';
import 'package:maids/domain/repositories/task_repository.dart';

import '../../data/remote/base_response_model.dart';

class CreateTaskUseCase{
  final TaskRepository _taskRepository;
  CreateTaskUseCase(this._taskRepository);

  Future<BasicResponse> call({required String todo})async{
    return await _taskRepository.createTask(todo: todo);
  }
}