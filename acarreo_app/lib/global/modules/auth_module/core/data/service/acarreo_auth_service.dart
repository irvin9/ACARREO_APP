import 'package:flutter/widgets.dart';
import 'package:acarreo_app/global/core/data/model/token_auth_model.dart';
import 'package:acarreo_app/global/core/domain/models/user_credential.dart';
import 'package:acarreo_app/global/modules/auth_module/core/domain/model/user_model.dart';
import 'package:acarreo_app/global/modules/auth_module/core/domain/service/auth_service.dart';
import 'package:acarreo_app/global/modules/auth_module/core/domain/repository/auth_repository.dart';

class AcarreoAuthService implements AuthService {
  final AuthRepository repository;

  const AcarreoAuthService({required this.repository});

  @override
  Future<UserModel?> getCurrentUser(int id) async {
    throw UnimplementedError();
  }

  @override
  Future<String?> login(UserCredential credential) async {
    try {
      final data = await repository.login(credential.toMap());
      TokenAuthModel tokenAuth = TokenAuthModel.fromMap(data);
      return tokenAuth.token;
    } catch (e, s) {
      debugPrint('Exception on -> ${runtimeType.toString()}');
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      return null;
    }
  }

  @override
  Future<void> logout() {
    throw UnimplementedError();
  }

  @override
  Future<UserModel?> verifyToken(String token) async {
    try {
      assert(token.isNotEmpty);
      final data = await repository.verifyToken(token);
      return UserModel.fromMap(data.toMap());
    } catch (e, s) {
      debugPrint('Exception on -> ${runtimeType.toString()}');
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      return null;
    }
  }
}
