import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/core/data/model/token_auth_model.dart';
import 'package:acarreo_app/global/modules/auth_module/core/domain/model/user_model.dart';
import 'package:acarreo_app/global/modules/auth_module/core/domain/service/auth_service.dart';
import 'package:acarreo_app/global/modules/auth_module/core/domain/repository/auth_repository.dart';

class AcarreoAuthService implements AuthService {
  final StorageService storage = Modular.get<StorageService>();
  final LocalStorageService localStorageService =
      Modular.get<LocalStorageService>();
  final AuthRepository repository;

  AcarreoAuthService({required this.repository});

  @override
  Future<UserModel?> getCurrentUser(int id) async {
    try {
      final data = await storage.getCurrentUser();
      final user = UserModel.fromMap(data.toMap());
      return user;
    } catch (e, s) {
      debugPrint('Exception on -> ${runtimeType.toString()}');
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      return null;
    }
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
  Future<bool> logout() async {
    try {
      await repository.logout();
      await localStorageService.clearAllStorage();
      await storage.deleteAll();
      return true;
    } catch (e, s) {
      debugPrint('Exception on -> ${runtimeType.toString()}');
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      return false;
    }
  }

  @override
  Future<UserModel?> verifyToken(String token) async {
    try {
      assert(token.isNotEmpty);
      await storage.saveToken(token);
      final data = await repository.verifyToken(token);
      await storage.saveUser(data);
      return UserModel.fromMap(data.toMap());
    } catch (e, s) {
      await storage.deleteAll();
      debugPrint('Exception on -> ${runtimeType.toString()}');
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      return null;
    }
  }
}
