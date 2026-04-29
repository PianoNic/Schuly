import 'package:flutter/material.dart';
import 'error_handler.dart';

/// Test utilities to verify error handling is working correctly
class TestErrors {
  /// Trigger a test exception to verify Sentry/GlitchTip integration
  static Future<void> triggerTestException({BuildContext? context}) async {
    try {
      throw Exception('Test exception from Schuly app - Error tracking is working!');
    } catch (e, stackTrace) {
      await ErrorHandler.captureException(
        e,
        stackTrace: stackTrace,
        userMessage: 'This is a test error. If you see this in GlitchTip, the integration is working!',
        context: context,
        extra: {
          'test_type': 'manual_trigger',
          'timestamp': DateTime.now().toIso8601String(),
        },
      );
    }
  }

  /// Trigger a null reference error
  static void triggerNullError() {
    String? nullString;
    // This will throw a null assertion error
    // ignore: avoid_print
    print(nullString!.length);
  }

  /// Trigger an async error
  static Future<void> triggerAsyncError() async {
    await Future.delayed(const Duration(seconds: 1));
    throw StateError('Async operation failed - Test error');
  }

  /// Trigger a network error simulation
  static Future<void> triggerNetworkError({BuildContext? context}) async {
    await ErrorHandler.handleApiError(
      Exception('Simulated network timeout'),
      endpoint: '/api/test',
      statusCode: 504,
      context: context,
    );
  }

  /// Add test breadcrumbs
  static void addTestBreadcrumbs() {
    ErrorHandler.addBreadcrumb(
      'User clicked test button',
      category: 'ui.click',
      data: {'button': 'test_error'},
    );

    ErrorHandler.addBreadcrumb(
      'Starting error test sequence',
      category: 'test',
      data: {'step': 1},
    );
  }

  /// Create a test button widget that can be added to any page
  static Widget createTestButton({BuildContext? context}) {
    return FloatingActionButton(
      mini: true,
      backgroundColor: Colors.red,
      onPressed: () async {
        addTestBreadcrumbs();
        await triggerTestException(context: context);
      },
      tooltip: 'Test Error Tracking',
      child: const Icon(Icons.bug_report, color: Colors.white),
    );
  }
}