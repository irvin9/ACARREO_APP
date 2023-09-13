import 'package:acarreo_app/global/core/domain/models/user_credential.dart';

abstract class AuthService {
  Future<String?> login(UserCredential credential);
  Future<dynamic> verifyUSer(String token);
  Future<dynamic> getCurrentUser(int id);
  Future<void> logout();
}
