import 'dart:async';

import 'package:floor/floor.dart';
import 'package:maids/data/local/dao/task_dao.dart';
import '../models/task.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
part 'app_database.g.dart';

@Database(version: 1, entities: [TaskModel])
abstract class AppDatabase extends FloorDatabase {
  TaskDao get taskDao;
}