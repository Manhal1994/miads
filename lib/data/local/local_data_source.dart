import 'package:maids/data/models/task.dart';

abstract class LocalDataSource {

 Future<List<TaskModel>> getTasks();

 Future<List<TaskModel>> getMyTasks(bool me);

 Future<void> insertTask(TaskModel taskModel);

 Future<void> updateTask(TaskModel taskModel);

 Future<void> deleteTask(TaskModel taskModel);

}