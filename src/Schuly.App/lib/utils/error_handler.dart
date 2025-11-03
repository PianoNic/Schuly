import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'logger.dart';

class ErrorHandler {
  /// Check if Sentry is initialized (has a DSN configured)
  static bool get isSentryEnabled {
    try {
      return Sentry.isEnabled;
    } catch (e) {
      return false;
    }
  }

  /// Captures an exception with context and optionally shows a user-friendly message
  static Future<void> captureException(
    dynamic exception, {
    StackTrace? stackTrace,
    String? userMessage,
    BuildContext? context,
    Map<String, dynamic>? extra,
    bool showSnackbar = true,
  }) async {
    // Log the error locally
    logError('Error captured: $exception', source: 'ErrorHandler');
    if (stackTrace != null) {
      logError('Stack trace: $stackTrace', source: 'ErrorHandler');
    }

    // Send to Sentry/GlitchTip only if enabled
    if (isSentryEnabled) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
        withScope: (scope) {
          if (extra != null) {
            scope.setContexts('extra', extra);
          }
          if (userMessage != null) {
            scope.setTag('user_message', userMessage);
          }
        },
      );
    }

    // Show user-friendly message if context is available
    if (context != null && showSnackbar && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(userMessage ?? 'An error occurred. Please try again.'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

  /// Wraps an async operation with error handling
  static Future<T?> handleAsync<T>(
    Future<T> Function() operation, {
    String? operationName,
    BuildContext? context,
    String? userMessage,
    T? defaultValue,
    bool showSnackbar = true,
  }) async {
    try {
      return await operation();
    } catch (error, stackTrace) {
      await captureException(
        error,
        stackTrace: stackTrace,
        userMessage: userMessage,
        context: context,
        extra: {
          'operation': operationName ?? 'Unknown operation',
        },
        showSnackbar: showSnackbar,
      );
      return defaultValue;
    }
  }

  /// Wraps a synchronous operation with error handling
  static T? handleSync<T>(
    T Function() operation, {
    String? operationName,
    BuildContext? context,
    String? userMessage,
    T? defaultValue,
    bool showSnackbar = true,
  }) {
    try {
      return operation();
    } catch (error, stackTrace) {
      captureException(
        error,
        stackTrace: stackTrace,
        userMessage: userMessage,
        context: context,
        extra: {
          'operation': operationName ?? 'Unknown operation',
        },
        showSnackbar: showSnackbar,
      );
      return defaultValue;
    }
  }

  /// Handles API errors specifically
  static Future<void> handleApiError(
    dynamic error, {
    StackTrace? stackTrace,
    String? endpoint,
    BuildContext? context,
    int? statusCode,
  }) async {
    String userMessage = 'Network error. Please check your connection.';

    if (statusCode != null) {
      switch (statusCode) {
        case 401:
          userMessage = 'Authentication failed. Please log in again.';
          break;
        case 403:
          userMessage = 'You don\'t have permission to perform this action.';
          break;
        case 404:
          userMessage = 'The requested resource was not found.';
          break;
        case 500:
          userMessage = 'Server error. Please try again later.';
          break;
        default:
          userMessage = 'An error occurred (Code: $statusCode).';
      }
    }

    await captureException(
      error,
      stackTrace: stackTrace,
      userMessage: userMessage,
      context: context,
      extra: {
        'endpoint': endpoint,
        'status_code': statusCode,
        'error_type': 'API_ERROR',
      },
    );
  }

  /// Creates a breadcrumb for navigation tracking
  static void addBreadcrumb(
    String message, {
    String? category,
    Map<String, dynamic>? data,
  }) {
    if (isSentryEnabled) {
      Sentry.addBreadcrumb(
        Breadcrumb(
          message: message,
          category: category,
          data: data,
          timestamp: DateTime.now(),
          level: SentryLevel.info,
        ),
      );
    }
  }

  /// Sets user context for error tracking
  static void setUserContext({
    String? userId,
    String? email,
    String? username,
    Map<String, dynamic>? extras,
  }) {
    if (isSentryEnabled) {
      Sentry.configureScope((scope) {
        scope.setUser(
          SentryUser(
            id: userId,
            email: email,
            username: username,
            data: extras,
          ),
        );
      });
    }
  }

  /// Clears user context (e.g., on logout)
  static void clearUserContext() {
    if (isSentryEnabled) {
      Sentry.configureScope((scope) {
        scope.setUser(null);
      });
    }
  }
}