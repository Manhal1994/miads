import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:maids/domain/enities/task_entity.dart';

@Entity(tableName: 'tasks', primaryKeys: ['id'])
class TaskModel extends Equatable {
  final String todo;
  final int? id;
  final bool? me;
  bool? completed;



  TaskModel({required this.todo, @PrimaryKey()  this.id, this.me, this.completed});

  factory TaskModel.fromJson(dynamic json){
    return TaskModel(todo: json["todo"]??"", id: json["id"], completed: json["completed"]??false);
  }
  TaskModel copy({required String todo}){
    return TaskModel(todo: todo, id: id);

  }

  @override
  List<Object?> get props => [id, todo];
}
