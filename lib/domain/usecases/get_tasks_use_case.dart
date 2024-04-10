import 'package:maids/data/models/task.dart';

import '../../data/models/page_data.dart';
import '../../data/remote/base_response_model.dart';
import '../repositories/task_repository.dart';

class GetTasksUseCases{
  final TaskRepository _taskRepository;
  GetTasksUseCases(this._taskRepository);

  Future<PageData<TaskModel>> call({required int limit, required int skip}) async{
    return await _taskRepository.getTasks(limit: limit, skip: skip);
  }
}