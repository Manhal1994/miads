import 'package:bloc/bloc.dart';
import 'package:maids/core/error/validator.dart';
import 'package:meta/meta.dart';

part 'validate_event.dart';
part 'validate_state.dart';

class ValidateBloc extends Bloc<ValidateEvent, ValidateState> {
  String userName = "";
  String password = "";
  ValidateBloc() : super(ValidateFailed()) {
    on<ValidateEvent>((event, emit) {
      if (event is OnInputChangeChange) {
        if (AuthValidator(userName: event.username, pass: event.password).validate()) {
          emit(ValidateSuccess());
        } else {
          emit(ValidateFailed());
        }
      }
    });
  }
}
