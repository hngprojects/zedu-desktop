import 'dart:developer' as dev;
import 'package:flutter/foundation.dart';

/// Log level severity, aligned with java.util.logging integers used by dart:developer.
enum LogLevel {
  verbose(300),
  debug(500),
  info(800),
  warning(900),
  error(1000),
  fatal(1200);

  const LogLevel(this.value);
  final int value;
}

/// Project-wide static logger backed by dart:developer.
///
/// In release builds, levels below [LogLevel.warning] are suppressed.
/// ANSI color formatting is applied only in debug builds.
///
/// Output appears in the Flutter DevTools "Logging" tab (not the Debug Console).
///
/// Usage:
///   AppLogger.d('Fetching tasks');
///   AppLogger.e('Login failed', tag: 'AuthNotifier', error: e, stackTrace: st);
abstract final class AppLogger {
  AppLogger._();

  static void v(String message, {String? tag}) =>
      _log(LogLevel.verbose, message, tag: tag);

  static void d(String message, {String? tag}) =>
      _log(LogLevel.debug, message, tag: tag);

  static void i(String message, {String? tag}) =>
      _log(LogLevel.info, message, tag: tag);

  static void w(
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) => _log(
    LogLevel.warning,
    message,
    tag: tag,
    error: error,
    stackTrace: stackTrace,
  );

  static void e(
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) => _log(
    LogLevel.error,
    message,
    tag: tag,
    error: error,
    stackTrace: stackTrace,
  );

  static void f(
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) => _log(
    LogLevel.fatal,
    message,
    tag: tag,
    error: error,
    stackTrace: stackTrace,
  );

  static void _log(
    LogLevel level,
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (kReleaseMode && level.value < LogLevel.warning.value) return;

    if (kDebugMode) {
      print('${tag ?? 'AppLogger'}: $message');
    }

    dev.log(
      kDebugMode ? '${_prefix(level)}$message\x1B[0m' : message,
      name: tag ?? 'AppLogger',
      level: level.value,
      error: error,
      stackTrace: stackTrace,
      time: DateTime.now(),
    );
  }

  static String _prefix(LogLevel level) => switch (level) {
    LogLevel.verbose => '\x1B[37m[V] ', // grey
    LogLevel.debug => '\x1B[36m[D] ', // cyan
    LogLevel.info => '\x1B[32m[I] ', // green
    LogLevel.warning => '\x1B[33m[W] ', // yellow
    LogLevel.error => '\x1B[31m[E] ', // red
    LogLevel.fatal => '\x1B[1;31m[F] ', // bold bright red
  };
}
