import 'package:maids/domain/repositories/auth_repository.dart';

import '../../data/remote/base_response_model.dart';
import '../../data/remote/dto/login_response.dart';

class LoginUseCase {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  Future<LoginResponse> call(
      {required String username, required String pass}) async {
    return await _authRepository.login(username: username, pass: pass);
  }
}
