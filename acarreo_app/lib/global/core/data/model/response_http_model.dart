import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:equatable/equatable.dart';

class ResponseHttpModel extends Equatable {
  final String body;
  final Map<String, String>? headers;

  final int statusCode;

  const ResponseHttpModel(
      {required this.body, this.headers, required this.statusCode});

  factory ResponseHttpModel.fromHttpFlutter(http.Response response) {
    return ResponseHttpModel(
      body: utf8.decode(response.body.codeUnits),
      headers: response.headers,
      statusCode: response.statusCode,
    );
  }

  factory ResponseHttpModel.fromJson(Map<String, dynamic> json) {
    return ResponseHttpModel(
      body: json['body'],
      headers: json['headers'] ?? {},
      statusCode: json['statusCode'],
    );
  }

  @override
  List<Object?> get props => [body, headers, statusCode];
}
