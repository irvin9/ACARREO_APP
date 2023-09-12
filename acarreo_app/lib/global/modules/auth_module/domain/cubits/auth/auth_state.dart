part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthRequest extends AuthState {
  final UserCredential credentials;

  const AuthRequest({required this.credentials});

  @override
  List<Object?> get props => [credentials];
}

class AuthProcessing extends AuthState {}

class AuthSuccess extends AuthState {
  final String token;

  const AuthSuccess({required this.token});

  @override
  List<Object?> get props => [token];
}

class AuthError extends AuthState {
  final String message;

  const AuthError({required this.message});

  @override
  List<Object?> get props => [message];
}
