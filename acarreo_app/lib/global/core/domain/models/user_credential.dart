import 'package:equatable/equatable.dart';

class UserCredential extends Equatable {
  const UserCredential({required this.username, required this.password});

  final String password;
  final String username;

  factory UserCredential.fromMap(Map<String, String> map) {
    return UserCredential(
      username: map['username'] as String,
      password: map['password'] as String,
    );
  }

  @override
  List<Object?> get props => [username, password];

  UserCredential copyWith({
    String? username,
    String? password,
  }) =>
      UserCredential(
        username: username ?? this.username,
        password: password ?? this.password,
      );
}
