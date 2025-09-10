import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'storage_service.dart';

class PushNotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();
  static bool _initialized = false;

  // Keys for storage
  static const String _pushAssistEnabledKey = 'push_assist_enabled';
  
  // Vibration pattern for notifications - distinct triple vibration
  static final Int64List _vibrationPattern = Int64List(6)
    ..[0] = 0      // Start delay
    ..[1] = 300    // Buzz 1
    ..[2] = 200    // Pause 1
    ..[3] = 300    // Buzz 2
    ..[4] = 200    // Pause 2
    ..[5] = 300;   // Buzz 3

  static Future<void> initialize() async {
    if (_initialized) return;

    // Initialize timezone database
    tz.initializeTimeZones();

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initializationSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // Create notification channels with proper vibration settings
    await _createNotificationChannels();

    _initialized = true;
  }

  static Future<void> _createNotificationChannels() async {
    // PushAssist channel with vibration
    const pushAssistChannel = AndroidNotificationChannel(
      'push_assist_channel',
      'PushAssist Benachrichtigungen',
      description: 'Benachrichtigungen vor Schulstunden',
      importance: Importance.high,
      enableVibration: true,
      enableLights: true,
      playSound: true,
    );

    // Test channel with vibration
    const testChannel = AndroidNotificationChannel(
      'test_channel',
      'Test Benachrichtigungen',
      description: 'Test Benachrichtigung für PushAssist',
      importance: Importance.high,
      enableVibration: true,
      enableLights: true,
      playSound: true,
    );

    await _notifications
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(pushAssistChannel);

    await _notifications
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(testChannel);

    debugPrint('Notification channels created with vibration enabled');
  }

  static void _onNotificationTapped(NotificationResponse response) {
    // Handle notification tap - could navigate to specific page
    debugPrint('Notification tapped: ${response.payload}');
  }

  // Request permissions for notifications
  static Future<bool> requestPermissions() async {
    if (!_initialized) await initialize();

    if (Platform.isAndroid) {
      final androidPermission = await Permission.notification.request();
      return androidPermission.isGranted;
    } else if (Platform.isIOS) {
      final result = await _notifications
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      return result ?? false;
    }
    return true;
  }

  // Check if permissions are granted
  static Future<bool> arePermissionsGranted() async {
    if (Platform.isAndroid) {
      return await Permission.notification.isGranted;
    } else if (Platform.isIOS) {
      final result = await _notifications
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.checkPermissions();
      return result?.isEnabled ?? false;
    }
    return true;
  }

  // PushAssist specific settings
  static Future<void> setPushAssistEnabled(bool enabled) async {
    final storage = FlutterSecureStorage();
    await storage.write(
      key: _pushAssistEnabledKey, 
      value: enabled.toString(),
    );
    
    if (!enabled) {
      // Cancel all scheduled notifications when disabled
      await cancelAllNotifications();
    }
  }

  static Future<bool> isPushAssistEnabled() async {
    final storage = FlutterSecureStorage();
    final value = await storage.read(key: _pushAssistEnabledKey);
    return value?.toLowerCase() == 'true'; // Default to false
  }

  // Schedule a notification for a specific agenda item
  static Future<void> scheduleAgendaNotification({
    required int id,
    required String subject,
    required String room,
    required String teacher,
    required DateTime startTime,
  }) async {
    if (!_initialized) await initialize();
    
    // Check if general notifications are enabled
    if (!await StorageService.getPushNotificationsEnabled()) return;
    
    // Check if agenda notifications are specifically enabled
    final agendaEnabled = await StorageService.getNotificationEnabled('agenda') ?? true;
    if (!agendaEnabled) return;

    // Check if permissions are granted
    if (!await arePermissionsGranted()) return;

    // Get advance time from settings (default 2 minutes)
    final advanceMinutes = await StorageService.getNotificationAdvanceMinutes() ?? 2;
    final notificationTime = startTime.subtract(Duration(minutes: advanceMinutes));
    
    // Don't schedule notifications for past events
    if (notificationTime.isBefore(DateTime.now())) return;

    final androidDetails = AndroidNotificationDetails(
      'push_assist_channel',
      'PushAssist Benachrichtigungen',
      channelDescription: 'Benachrichtigungen vor Schulstunden',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      enableVibration: true,
      enableLights: true,
      vibrationPattern: _vibrationPattern,
      icon: '@mipmap/ic_launcher',
      category: AndroidNotificationCategory.alarm,
      timeoutAfter: 30000, // Show for 30 seconds
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    final title = 'Nächste Stunde: $subject';
    final body = 'Raum: $room${teacher.isNotEmpty ? ' • Lehrer: $teacher' : ''}';

    await _notifications.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(notificationTime, tz.local),
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );

    debugPrint('Scheduled notification for $subject at ${notificationTime.toString()}');
  }

  // Schedule notifications for multiple agenda items
  static Future<void> scheduleAgendaNotifications(List<dynamic> agendaItems) async {
    // Check if general notifications are enabled
    if (!await StorageService.getPushNotificationsEnabled()) return;
    
    // Check if agenda notifications are specifically enabled
    final agendaEnabled = await StorageService.getNotificationEnabled('agenda') ?? true;
    if (!agendaEnabled) return;
    
    // Cancel existing notifications first
    await cancelAllNotifications();

    int notificationId = 1000; // Start with a high number to avoid conflicts

    for (final item in agendaItems) {
      try {
        final startDateTime = DateTime.tryParse(item.startDate);
        if (startDateTime == null) continue;

        // Only schedule for today and future dates
        final today = DateTime.now();
        if (startDateTime.isBefore(DateTime(today.year, today.month, today.day))) {
          continue;
        }

        await scheduleAgendaNotification(
          id: notificationId++,
          subject: item.text ?? 'Unbekannt',
          room: item.roomToken ?? 'Unbekannt',
          teacher: '', // Teacher field doesn't exist in AgendaDto
          startTime: startDateTime,
        );
      } catch (e) {
        debugPrint('Error scheduling notification for agenda item: $e');
      }
    }
  }

  // Cancel all notifications
  static Future<void> cancelAllNotifications() async {
    if (!_initialized) await initialize();
    await _notifications.cancelAll();
    debugPrint('All notifications cancelled');
  }

  // Cancel a specific notification
  static Future<void> cancelNotification(int id) async {
    if (!_initialized) await initialize();
    await _notifications.cancel(id);
  }

  // Get pending notifications (for debugging)
  static Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    if (!_initialized) await initialize();
    return await _notifications.pendingNotificationRequests();
  }

  // Show a test notification
  static Future<void> showTestNotification() async {
    if (!_initialized) await initialize();

    debugPrint('🔔 Showing test notification...');

    final androidDetails = AndroidNotificationDetails(
      'test_channel',
      'Test Benachrichtigungen',
      channelDescription: 'Test Benachrichtigung für PushAssist',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      enableVibration: true,
      enableLights: true,
      vibrationPattern: _vibrationPattern,
      ticker: 'Test Notification',
      autoCancel: true,
      ongoing: false,
      category: AndroidNotificationCategory.alarm,
      timeoutAfter: 10000, // Show for 10 seconds
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    try {
      await _notifications.show(
        0,
        '🔔 PushAssist Vibration Test',
        'Diese Benachrichtigung sollte vibrieren! Prüfen Sie Ihre Geräteeinstellungen falls nicht.',
        notificationDetails,
      );
      debugPrint('✅ Test notification shown successfully');
    } catch (e) {
      debugPrint('❌ Failed to show test notification: $e');
    }
  }
}