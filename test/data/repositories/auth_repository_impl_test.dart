import 'package:flutter_test/flutter_test.dart';
import 'package:maids/data/remote/dto/basic_response.dart';
import 'package:maids/data/remote/dto/login_response.dart';
import 'package:maids/data/remote/remote_data_source.dart';
import 'package:maids/data/repositories/auth_repository_impl.dart';
import 'package:maids/domain/usecases/create_task_use_case.dart';
import 'package:mockito/mockito.dart';
import '../../generated_test_dependency_test.mocks.dart';


void main() {

  late AuthRepositoryImpl authRepositoryImpl ;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;


  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    authRepositoryImpl = AuthRepositoryImpl(mockRemoteDataSource,mockLocalDataSource);
  });
  const userName = "Mhjj7gggg";
  const pass = "123456";
  const token = "some token";

  const endpoint = "/auth/login";
  final data = {
  "username": userName,
  "password": pass
  };

  test(
    'should get return [LoginResponse] for success logon',
        () async {
      // arrange
      when(mockRemoteDataSource.post(endpoint: endpoint, data: data, ))
          .thenAnswer((_) async => {"token": token});
      // act
      final result = await authRepositoryImpl.login(username: userName, pass: pass);
      // assert
      expect(result, LoginResponse(token: token));
    },
  );
}
