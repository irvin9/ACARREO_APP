import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/auth_module/core/domain/service/auth_service.dart';
import 'package:acarreo_app/global/modules/auth_module/core/domain/model/user_model.dart';
import 'package:flutter/material.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.service}) : super(const AuthInitial());

  final AuthService service;

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
    }
    _isLoading = false;
    emit(currentState);
  }

  logout() async {
    AuthState currentState = const AuthInitCloseSession();
    emit(currentState);
    currentState = const AuthCloseSessionSuccess();
    await service.logout();
    emit(currentState);
    goToNavigate(GlobalRoutesApp.authLoginRoute);
  }

  Future<void> goToNavigate(String route) async {
    Modular.to.navigate(route);
  }
}
