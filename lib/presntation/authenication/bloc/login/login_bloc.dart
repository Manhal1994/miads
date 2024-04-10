import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maids/core/error/app_error.dart';
import '../../../../domain/usecases/login_use_case.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;
  LoginBloc(this.loginUseCase) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is Login) {
        try {
          emit(LoginLoading());
          await loginUseCase.call(
              username: event.username, pass: event.password);
          emit(LoginSuccess());
        } on AppError catch (e) {
          emit(LoginError(e.message));
        }
      }
    });
  }
}
