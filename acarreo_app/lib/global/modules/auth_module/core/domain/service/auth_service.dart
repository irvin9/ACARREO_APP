import 'package:acarreo_app/global/core/domain/models/user_credential.dart';
import 'package:acarreo_app/global/modules/auth_module/core/domain/model/user_model.dart';

abstract class AuthService {
  Future<String?> login(UserCredential credential);
  Future<UserModel?> verifyToken(String token);
  Future<UserModel?> getCurrentUser(int id);
  Future<bool> logout();
}
