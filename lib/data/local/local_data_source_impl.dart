import 'package:maids/data/local/local_data_source.dart';
import 'package:maids/data/models/task.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_database.dart';

class LocalDatabaseImpl extends LocalDataSource{
  final AppDatabase _db;
  final SharedPreferences _pres;

  final String TOKEN_KEY = "TOKEN_KEY";

  LocalDatabaseImpl(this._db, this._pres);

  @override
  Future<void> deleteTask(TaskModel taskModel) async{
    await _db.taskDao.deleteTask(taskModel);
  }

  @override
  Future<void> insertTask(TaskModel taskModel) async{
    return await _db.taskDao.insertTask(taskModel);
  }

  @override
  Future<void> updateTask(TaskModel taskModel) async{
    await _db.taskDao.updateTask(taskModel);
  }

  @override
  Future<List<TaskModel>> getTasks() async{
   return await _db.taskDao.getTasks();
  }

  @override
  Future<List<TaskModel>> getMyTasks(bool me) async{
    return await _db.taskDao.getMyTasks(me);

  }

  @override
  Future<void> saveToken(String token) async{
     await _pres.setString(TOKEN_KEY, token);
  }

  @override
  String? getToken() {
    return _pres.getString(TOKEN_KEY);
  }

}