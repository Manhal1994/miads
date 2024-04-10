import 'base_response_model.dart';

abstract class RemoteDataSource {
  Future<dynamic> get(
      {required String endpoint, String? token, dynamic params});

  Future<dynamic> post(
      {required String endpoint, Map<String,dynamic>? data, dynamic params, String? token});

  Future<dynamic> put(
      {required String endpoint, dynamic data, dynamic params, String? token});

  Future<dynamic> delete(
      {required String endpoint, dynamic data, dynamic params, String? token});
}
