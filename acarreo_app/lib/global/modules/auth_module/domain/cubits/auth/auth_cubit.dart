import 'package:acarreo_app/global/core/domain/models/user_credential.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final Map<String, String> _credentials = {};
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  Map<String, String> get credentials => _credentials;

  AuthCubit() : super(const AuthInitial());

  login(UserCredential credentials) async {
    _isLoading = true;
    AuthState currentState = AuthProcessing();
    debugPrint(credentials.toString());
    emit(currentState);

    String? token;
    currentState = const AuthError(message: 'Ocurrio un error');
    await Future.delayed(const Duration(seconds: 10), () {
      token = 'd';
    });
    if (token != null) {
      currentState = AuthSuccess(token: token!);
    }
    _isLoading = false;
    emit(currentState);
  }
}
