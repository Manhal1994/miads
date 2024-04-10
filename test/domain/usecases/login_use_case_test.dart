import 'package:flutter_test/flutter_test.dart';
import 'package:maids/data/models/task.dart';
import 'package:maids/data/remote/dto/basic_response.dart';
import 'package:maids/data/remote/dto/login_response.dart';
import 'package:maids/domain/repositories/auth_repository.dart';
import 'package:maids/domain/repositories/task_repository.dart';
import 'package:maids/domain/usecases/create_task_use_case.dart';
import 'package:maids/domain/usecases/delete_task_use_case.dart';
import 'package:maids/domain/usecases/login_use_case.dart';
import 'package:maids/domain/usecases/update_task_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../generated_test_dependency_test.mocks.dart';

void main() {
  late AuthRepository mockAuthRepository;
  late LoginUseCase loginUseCase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    loginUseCase = LoginUseCase(mockAuthRepository);
  });

  const token = "some token";
  final loginResponse = LoginResponse(token: token);

  const userName = "Mhjj7gggg";
  const pass = "123456";

  test(
    'should get [LoginResponse] from the [AuthRepository]',
    () async {
      // arrange
      when(mockAuthRepository.login(username: userName, pass: pass))
          .thenAnswer((_) async => LoginResponse(token: token));
      // act
      final result = await loginUseCase.call(pass: pass, username: userName);
      // assert
      expect(result, loginResponse);
      verify(mockAuthRepository.login(pass: pass, username: userName));
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );
}
