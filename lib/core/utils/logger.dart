import 'package:logger/logger.dart';

class AppLog {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      lineLength: 100,
      printEmojis: true,
    ),
  );

  static void i(Object msg) => _logger.i(msg);
  static void w(Object msg) => _logger.w(msg);
  static void e(Object msg, [Object? err, StackTrace? st]) => _logger.e(msg, error: err, stackTrace: st);
}