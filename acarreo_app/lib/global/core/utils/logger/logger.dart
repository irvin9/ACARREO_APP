import 'package:logger/logger.dart';

class Log {
  static final Logger _logger = Logger(
    filter: null, // Use the default LogFilter (-> only log in debug mode)
    output: null,
    printer: PrettyPrinter(
      colors: false, // Colorful log messages
      printEmojis: true, // Print an emoji for each log message
    ),
  );

  static void trace(dynamic message) {
    _logger.t(message);
  }

  static void debug(dynamic message) {
    _logger.d(message);
  }

  static void info(dynamic message) {
    _logger.i(message);
  }

  static void warning(dynamic message) {
    _logger.w(message);
  }

  static void error(dynamic message, {Object? error, StackTrace? stackTrace}) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  static void fatal(dynamic message, {Object? error, StackTrace? stackTrace}) {
    _logger.f(message, error: error, stackTrace: stackTrace);
  }
}
