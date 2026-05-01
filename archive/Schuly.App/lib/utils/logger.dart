import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../providers/logging_service.dart';

/// Global logger instance that can be used throughout the app
/// Usage: logger.info('message', source: 'ClassName');
class Logger {
  static LoggingService? _service;
  static BuildContext? _context;

  static void init(BuildContext context) {
    _context = context;
    _service = null; // Reset to ensure fresh provider lookup
  }

  static LoggingService get _logger {
    if (_service != null) return _service!;

    // Try to get from context if available
    if (_context != null) {
      try {
        _service = Provider.of<LoggingService>(_context!, listen: false);
        return _service!;
      } catch (e) {
        // Context might be disposed or provider not found
      }
    }

    // Fallback to a standalone instance if no context
    _service ??= LoggingService();
    return _service!;
  }

  static void debug(String message, {String? source}) {
    _logger.debug(message, source: source);
  }

  static void info(String message, {String? source}) {
    _logger.info(message, source: source);
  }

  static void warning(String message, {String? source}) {
    _logger.warning(message, source: source);
  }

  static void error(String message, {String? source, dynamic error, StackTrace? stackTrace}) {
    _logger.error(message, source: source, error: error, stackTrace: stackTrace);
  }
}

/// Convenience global logger instance - use these functions directly
void logDebug(String message, {String? source}) => Logger.debug(message, source: source);
void logInfo(String message, {String? source}) => Logger.info(message, source: source);
void logWarning(String message, {String? source}) => Logger.warning(message, source: source);
void logError(String message, {String? source, dynamic error, StackTrace? stackTrace}) =>
    Logger.error(message, source: source, error: error, stackTrace: stackTrace);