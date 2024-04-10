abstract class Validator{
  bool validate();
}

class AuthValidator extends Validator{
  final String userName;
  final String pass;
  AuthValidator({required this.pass, required this.userName});

  @override
  bool validate() {
    return userName.trim().length>5 && pass.trim().length>5;
  }
}

class AddTaskValidator extends Validator{
  final String todo;
  AddTaskValidator({required this.todo});

  @override
  bool validate() {
   return todo.trim().length>2;
  }


}