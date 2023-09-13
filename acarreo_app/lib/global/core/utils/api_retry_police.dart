import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:http_interceptor/http_interceptor.dart';

class ApiRetryPolicy extends RetryPolicy {
  @override
  int get maxRetryAttempts => 2;

  @override
  Future<bool> shouldAttemptRetryOnResponse(BaseResponse response) async {
    if (response.statusCode == HttpStatus.unprocessableEntity) {
      debugPrint('Se esta reintentando peticion -> ${response.request?.url}');
      return true;
    }
    return false;
  }
}
