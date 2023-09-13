import 'package:acarreo_app/global/core/domain/service/storage_service.dart';
import 'package:acarreo_app/global/modules/auth_module/domain/model/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:acarreo_app/global/core/domain/models/user_credential.dart';
import 'package:acarreo_app/global/modules/auth_module/domain/service/auth_service.dart';

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
    await storage.saveToken(token);
    final user = await service.verifyToken(token);
    if (user != null) {
      currentState = AuthSuccess(user: user);
    } else {
      await storage.deleteAll();
    }
    _isLoading = false;
    emit(currentState);
  }
}
