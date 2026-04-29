import 'package:flutter/services.dart';

class UrlLauncherHelper {
  static const MethodChannel _channel = MethodChannel('schuly/url_launcher');

  /// Launch email with subject
  static Future<bool> launchEmail(String email, {String? subject}) async {
    try {
      final result = await _channel.invokeMethod('launchEmail', {
        'email': email,
        'subject': subject,
      });
      return result == true;
    } catch (e) {
      return false;
    }
  }

  /// Launch URL in browser
  static Future<bool> launchUrl(String url) async {
    try {
      final result = await _channel.invokeMethod('launchUrl', {
        'url': url,
      });
      return result == true;
    } catch (e) {
      return false;
    }
  }
}