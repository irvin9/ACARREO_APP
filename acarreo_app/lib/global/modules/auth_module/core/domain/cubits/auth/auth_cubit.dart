import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/auth_module/core/domain/service/auth_service.dart';
import 'package:acarreo_app/global/modules/auth_module/core/domain/model/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.service, required this.storage})
      : super(const AuthInitial());

  final AuthService service;
  final StorageService storage;

  final Map<String, String> _credentials = {};
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Map<String, String> get credentials => _credentials;

  login(UserCredential credential) async {
    _isLoading = true;
    AuthState currentState = AuthProcessing();
    emit(currentState);

    currentState = const AuthError(message: 'Ocurrio un error');
    String? token;
    token = await service.login(credential) ?? '';
    final user = await service.verifyToken(token);
    if (user != null) {
      currentState = AuthSuccess(user: user);
    } else {
      await storage.deleteAll();
    }
    _isLoading = false;
    emit(currentState);
  }

  logout() async {
    AuthState currentState = const AuthInitCloseSession();
    emit(currentState);

    currentState = const AuthCloseSessionSuccess();
    await service.logout().then((_) async {
      await storage.deleteAll();
      emit(currentState);
      Modular.to.navigate(GlobalRoutesApp.authLoginRoute);
    });
  }

  Future<void> goToNavigate(String route) async {
    Modular.to.navigate(
      route,
    );
  }
}
