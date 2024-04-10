import 'package:equatable/equatable.dart';

class BasicResponse extends Equatable{
   int? id;
   String? todo;

   BasicResponse({this.id, this.todo});

  BasicResponse.fromJson(Map<String,dynamic> json){
    id = json["id"];
    todo = json["title"];
  }

  @override
  List<Object?> get props => [id, todo];

}