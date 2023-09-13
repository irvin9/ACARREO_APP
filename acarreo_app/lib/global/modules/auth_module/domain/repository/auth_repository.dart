abstract class AuthRepository {
  Future<Map<String, dynamic>> login(Map<String, dynamic> credential);

  Future<dynamic> verifyUSer(String token);

  Future<dynamic> getCurrentUser(int id);

  Future<void> logout();
}
