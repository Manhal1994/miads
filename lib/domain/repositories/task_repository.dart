import 'package:maids/data/models/page_data.dart';
import 'package:maids/data/models/task.dart';
import 'package:maids/data/remote/dto/basic_response.dart';

import '../../data/remote/base_response_model.dart';

abstract class TaskRepository{
  Future<BasicResponse> createTask({required String todo});
  Future<BasicResponse> updateTask({required TaskModel taskModel});
  Future<BasicResponse> deleteTask({required TaskModel taskModel});
  Future<PageData<TaskModel>> getTasks({required int skip, required int limit});
}