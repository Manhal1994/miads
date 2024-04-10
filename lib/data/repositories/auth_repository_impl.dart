import 'package:flutter/cupertino.dart';
import 'package:maids/data/remote/remote_data_source.dart';
import 'package:maids/domain/repositories/auth_repository.dart';
import '../remote/dto/login_response.dart';

class AuthRepositoryImpl extends AuthRepository{
  final RemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<LoginResponse> login({required String username, required String pass}) async{
    final res = await _remoteDataSource.post(endpoint: "/auth/login", data: {
      "username": username,
      "password": pass
    });
    return LoginResponse.fromJson(res);
  }

}