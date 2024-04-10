import 'package:flutter/cupertino.dart';
import 'package:maids/core/error/app_error.dart';
import 'package:maids/data/local/local_data_source.dart';
import 'package:maids/data/models/page_data.dart';
import 'package:maids/data/models/task.dart';
import 'package:maids/data/remote/base_response_model.dart';
import 'package:maids/data/remote/dto/basic_response.dart';
import 'package:maids/data/remote/remote_data_source.dart';
import 'package:maids/domain/repositories/task_repository.dart';

class TaskRepositoryImpl extends TaskRepository {
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDatSource;

  TaskRepositoryImpl(this._remoteDataSource, this._localDatSource);
  @override
  Future<BasicResponse> createTask({required String todo, bool me = true}) async {
    final resJson = await _remoteDataSource
        .post(endpoint: "/products/add", data: {"title": todo});
    // Save to database
    int id = DateTime.now().millisecondsSinceEpoch;
    final taskdb = TaskModel(todo: todo, id: id, me: true, completed: false);
    await _localDatSource.insertTask(taskdb);
    if(me) {
      resJson["id"] = id;
    }
    BasicResponse addTaskResponse = BasicResponse.fromJson(resJson);
    return addTaskResponse;
  }

  @override
  Future<PageData<TaskModel>> getTasks(
      {required int skip, required int limit}) async {
    final param = {"skip": skip, "limit": limit};
    try {
      // Get tasks from Network
      final res =
          await _remoteDataSource.get(endpoint: "/todos", params: param);
      final page = PageData<TaskModel>.fromJson(res, TaskModel.fromJson);

      // add tasks db to network

      // Cashing
      for (var task in page.items) {
        await _localDatSource.insertTask(task);
      }

      // Get tasks from database that i have inserted and put them on the top for the first page
      if (skip == 0) {
        final myTasks = await _localDatSource.getMyTasks(true);
        page.items.insertAll(0, myTasks.reversed);
      }

      return page;
    }  on AppError catch (e, t) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: t);
      final tasks = await _localDatSource.getTasks();
      final page = PageData<TaskModel>(total:tasks.length, skip: 0, limit: 10, items: tasks );
      return page;
    }
  }

  @override
  Future<BasicResponse> updateTask({required TaskModel taskModel}) async {
    Map<String, dynamic> resJson = {
      "id": taskModel.id,
      "title": taskModel.todo
    };

    if (!(taskModel.me ?? false)) {
      resJson = await _remoteDataSource.put(
          endpoint: "/products/${taskModel.id}",
          data: {"title": taskModel.todo});
    }
    BasicResponse addTaskResponse = BasicResponse.fromJson(resJson);
    await _localDatSource.updateTask(
        TaskModel(todo: addTaskResponse.todo!, id: taskModel.id, me: true, completed: taskModel.completed));
    return addTaskResponse;
  }

  @override
  Future<BasicResponse> deleteTask({required TaskModel taskModel}) async {
    Map<String, dynamic> resJson = {
      "id": taskModel.id,
      "title": taskModel.todo
    };
    if (!(taskModel.me ?? false)) {
      resJson = await _remoteDataSource.delete(
          endpoint: "/products/${taskModel.id}",
          data: {"title": taskModel.todo});
    }
    BasicResponse addTaskResponse = BasicResponse.fromJson(resJson);

    await _localDatSource.deleteTask(taskModel);
    return addTaskResponse;
  }
}
