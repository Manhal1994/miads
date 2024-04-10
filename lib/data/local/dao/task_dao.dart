import 'package:floor/floor.dart';
import 'package:maids/data/models/task.dart';

@dao
abstract class TaskDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertTask(TaskModel taskModel);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateTask(TaskModel taskModel);

  @delete
  Future<void> deleteTask(TaskModel taskModel);

  @Query('SELECT * FROM tasks')
  Future<List<TaskModel>> getTasks();

  @Query('SELECT * FROM tasks where me = :me')
  Future<List<TaskModel>> getMyTasks(bool me);
}