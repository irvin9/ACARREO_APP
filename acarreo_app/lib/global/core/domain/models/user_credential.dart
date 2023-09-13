import 'package:equatable/equatable.dart';

class UserCredential extends Equatable {
  const UserCredential({required this.user, required this.password});

  factory UserCredential.fromMap(Map<String, String> map) {
    return UserCredential(
      user: map['user'] as String,
      password: map['password'] as String,
    );
  }

  final String password;
  final String user;

  Map<String, dynamic> toMap() => {
        "user": user,
        "password": password,
      };

  @override
  List<Object?> get props => [user, password];

  UserCredential copyWith({
    String? user,
    String? password,
  }) =>
      UserCredential(
        user: user ?? this.user,
        password: password ?? this.password,
      );
}
