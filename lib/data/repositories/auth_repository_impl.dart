import 'package:maids/data/local/local_data_source.dart';
import 'package:maids/data/remote/remote_data_source.dart';
import 'package:maids/domain/repositories/auth_repository.dart';
import '../remote/dto/login_response.dart';

class AuthRepositoryImpl extends AuthRepository{
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;


  AuthRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<LoginResponse> login({required String username, required String pass}) async{
    final res = await _remoteDataSource.post(endpoint: "/auth/login", data: {
      "username": username,
      "password": pass
    });

    final loginResponse = LoginResponse.fromJson(res);
    if(loginResponse.token!=null){
      _localDataSource.saveToken(loginResponse.token!);
    }

    return loginResponse;
  }

}