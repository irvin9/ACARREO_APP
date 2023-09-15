import 'package:acarreo_app/global/core/data/model/user_auth_model.dart';

abstract class AuthRepository {
  Future<Map<String, dynamic>> login(Map<String, dynamic> credential);

  Future<UserAuthModel> verifyToken(String token);

  Future<dynamic> getCurrentUser(int id);

  Future<void> logout();
}
