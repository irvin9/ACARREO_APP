class TokenAuthModel {
  final String token;

  const TokenAuthModel({required this.token});

  factory TokenAuthModel.fromMap(Map<String, dynamic> data) => TokenAuthModel(
        token: data['token'],
      );
}
