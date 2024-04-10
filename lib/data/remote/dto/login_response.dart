import 'package:equatable/equatable.dart';

class LoginResponse extends Equatable{
  int? id;
  String? username;
  String? email;
  String? firstName;
  String? lastName;
  String? gender;
  String? image;
  String? token;

  LoginResponse({required this.token});

  LoginResponse.fromJson(Map<String, dynamic> json){
   id = json["id"]?? -1;
   username = json["username"]??"";
   email = json["email"];
   firstName = json["firstName"]??"";
   lastName = json["lastName"];
   gender = json["gender"]??"";
   image = json["image"]??"";
   token = json["token"]??"";

  }

  @override
  List<Object?> get props => [token];
}