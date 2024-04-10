import 'package:flutter_test/flutter_test.dart';
import 'package:maids/core/error/app_error.dart';
import 'package:maids/data/remote/dto/basic_response.dart';
import 'package:maids/data/remote/dto/login_response.dart';
import 'package:maids/data/remote/remote_data_source.dart';
import 'package:maids/data/repositories/auth_repository_impl.dart';
import 'package:maids/domain/usecases/create_task_use_case.dart';
import 'package:maids/presntation/authenication/bloc/login/login_bloc.dart';
import 'package:mockito/mockito.dart';
import '../../../../generated_test_dependency_test.mocks.dart';

void main() {
  late MockLoginUseCase mockLoginUseCase;
  late LoginBloc loginBloc;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    loginBloc = LoginBloc(mockLoginUseCase);
  });
  test('log should be Empty', () {
// assert
    expect(loginBloc.state, equals(LoginInitial()));
  });

  test('LoginState should be login Success after login with success', () {
    // arrange
    when(mockLoginUseCase.call(username: "tgtttt", pass: "hhg7443"))
        .thenAnswer((_) async => LoginResponse(token: "Some token"));

    // assert
    final expected = [
      LoginLoading(),
      LoginSuccess(),
    ];
    expectLater(loginBloc.stream, emitsInOrder(expected));

    // act
    loginBloc.add(const Login(username: 'tgtttt', password: "hhg7443"));
  });

  test('LoginState should be login Success after login with success', () {
    // arrange
    when(mockLoginUseCase.call(username: "tgtttt", pass: "hhg7443"))
        .thenThrow(AppError(message: "Invalid login"));

    // assert
    final expected = [
      LoginLoading(),
      const LoginError("Invalid login"),
    ];
    expectLater(loginBloc.stream, emitsInOrder(expected));

    // act
    loginBloc.add(const Login(username: 'tgtttt', password: "hhg7443"));
  });
}
