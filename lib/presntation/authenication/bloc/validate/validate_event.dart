part of 'validate_bloc.dart';

@immutable
abstract class ValidateEvent {}
class OnInputChangeChange extends ValidateEvent{
  final String username;
  final String password;
  OnInputChangeChange(this.username, this.password);
}


