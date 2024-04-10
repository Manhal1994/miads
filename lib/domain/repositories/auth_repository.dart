import 'package:maids/data/remote/base_response_model.dart';

import '../../data/remote/dto/login_response.dart';

abstract class AuthRepository {
  Future<LoginResponse> login({required String username, required String pass});
}
