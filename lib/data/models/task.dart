import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:maids/domain/enities/task_entity.dart';

@Entity(tableName: 'tasks', primaryKeys: ['id'])
class TaskModel extends Equatable {
  final String todo;
  final int? id;
  final bool? me;


  TaskModel({required this.todo, @PrimaryKey()  this.id, this.me});

  factory TaskModel.fromJson(dynamic json){
    return TaskModel(todo: json["todo"]??"", id: json["id"]);
  }
  TaskModel copy({required String todo}){
    return TaskModel(todo: todo, id: id);

  }

  @override
  List<Object?> get props => [id, todo];
}
