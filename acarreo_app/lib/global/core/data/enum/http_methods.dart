// ignore_for_file: constant_identifier_names

enum HttpMethods {
  POST,
  GET,
  PUT,
  DELETE,
  PATCH,
}

extension HttpMethodsExtension on HttpMethods {
  String get verb {
    switch (this) {
      case HttpMethods.POST:
        return 'POST';
      case HttpMethods.GET:
        return 'GET';
      case HttpMethods.PUT:
        return 'PUT';
      case HttpMethods.DELETE:
        return 'DELETE';
      case HttpMethods.PATCH:
        return 'PATCH';
      default:
        return 'default';
    }
  }
}
