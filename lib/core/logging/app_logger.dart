import 'package:logger/logger.dart';

class AppLogger {
  static final AppLogger _instance = AppLogger._internal();
  factory AppLogger() => _instance;
  AppLogger._internal();

  final Logger _logger = Logger(printer: PrefixPrinter(SimplePrinter()));

  void error(dynamic error, {StackTrace? stackTrace}) {
    _logger.e(error, stackTrace: stackTrace);
  }

  void info(dynamic message) {
    _logger.i(message);
  }

  void debug(dynamic message) {
    _logger.d(message);
  }

  void warning(dynamic message) {
    _logger.w(message);
  }
}
