import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'storage_service.dart';
import '../l10n/app_localizations.dart';

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

    // Try to detect and set the local timezone
    try {
      // For Windows/Europe, we'll try common European timezones
      // You can adjust this based on your actual location
      final String timezoneName = 'Europe/Berlin'; // Change this to your timezone
      final location = tz.getLocation(timezoneName);
      tz.setLocalLocation(location);
      debugPrint('Timezone set to: $timezoneName');
    } catch (e) {
      // Fallback to UTC if timezone not found
      debugPrint('Failed to set timezone, using UTC: $e');
      tz.setLocalLocation(tz.UTC);
    }

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      // Show notifications even when app is in foreground
      defaultPresentAlert: true,
      defaultPresentBadge: true,
      defaultPresentSound: true,
    );

    const initializationSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
      onDidReceiveBackgroundNotificationResponse: _onNotificationTapped,
    );

    // Create notification channels with proper vibration settings
    await _createNotificationChannels();

    _initialized = true;
  }

  static Future<void> _createNotificationChannels() async {
    // Create new channels with unique IDs to force recreation
    final timestamp = DateTime.now().millisecondsSinceEpoch;

    // Use fresh channel IDs
    const pushAssistChannel = AndroidNotificationChannel(
      'schuly_notifications_v2', // New channel ID
      'Schuly Benachrichtigungen',
      description: 'Wichtige Benachrichtigungen von Schuly',
      importance: Importance.max,
      enableVibration: true,
      enableLights: true,
      playSound: true,
      showBadge: true,
    );

    // Test channel with vibration
    const testChannel = AndroidNotificationChannel(
      'schuly_test_v2', // New channel ID
      'Schuly Test',
      description: 'Test Benachrichtigungen',
      importance: Importance.max,
      enableVibration: true,
      enableLights: true,
      playSound: true,
      showBadge: true,
    );

    await _notifications
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(pushAssistChannel);

    await _notifications
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(testChannel);

    debugPrint('Notification channels recreated with max importance');
  }

  @pragma('vm:entry-point')
  static void _onNotificationTapped(NotificationResponse response) {
    // Handle notification tap - could navigate to specific page
    debugPrint('Notification tapped: ${response.payload}');
  }

  // Request permissions for notifications
  static Future<bool> requestPermissions() async {
    if (!_initialized) await initialize();

    if (Platform.isAndroid) {
      // Request notification permission
      final androidPermission = await Permission.notification.request();
      if (!androidPermission.isGranted) return false;

      // For Android 12+ (API 31+), also request exact alarm permission
      if (await Permission.scheduleExactAlarm.isDenied) {
        final exactAlarmPermission = await Permission.scheduleExactAlarm.request();
        if (!exactAlarmPermission.isGranted) {
          debugPrint('Exact alarm permission denied - notifications may not work properly');
        }
      }

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
      final notificationGranted = await Permission.notification.isGranted;
      final exactAlarmGranted = await Permission.scheduleExactAlarm.isGranted;
      return notificationGranted && exactAlarmGranted;
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
    AppLocalizations? localizations,
  }) async {
    if (!_initialized) await initialize();

    // Check if general notifications are enabled
    if (!await StorageService.getPushNotificationsEnabled()) return;

    // Check if agenda notifications are specifically enabled
    final agendaEnabled = await StorageService.getNotificationEnabled('agenda') ?? true;
    if (!agendaEnabled) return;

    // Check if permissions are granted
    if (!await arePermissionsGranted()) {
      debugPrint('Permissions not granted for notifications');
      return;
    }

    // Check exact alarm permission for Android
    if (Platform.isAndroid && !await Permission.scheduleExactAlarm.isGranted) {
      debugPrint('Exact alarm permission not granted - cannot schedule notification');
      return;
    }

    // Get advance time from settings (default 2 minutes)
    final advanceMinutes = await StorageService.getNotificationAdvanceMinutes() ?? 2;
    final notificationTime = startTime.subtract(Duration(minutes: advanceMinutes));
    
    // Don't schedule notifications for past events
    if (notificationTime.isBefore(DateTime.now())) return;

    final androidDetails = AndroidNotificationDetails(
      'schuly_notifications_v2',
      'Schuly Benachrichtigungen',
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

    // Convert to TZDateTime properly
    final tzNotificationTime = tz.TZDateTime.from(notificationTime, tz.local);

    await _notifications.zonedSchedule(
      id,
      title,
      body,
      tzNotificationTime,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.alarmClock, // Better for Samsung
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
          subject: item.text ?? 'Unknown',
          room: item.roomToken ?? 'Unknown',
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

  // Request exact alarm permission (Android 12+)
  static Future<bool> requestExactAlarmPermission() async {
    if (Platform.isAndroid) {
      if (await Permission.scheduleExactAlarm.isDenied) {
        // On Android 12+, this opens the app settings where user can enable exact alarms
        final status = await Permission.scheduleExactAlarm.request();
        return status.isGranted;
      }
      return await Permission.scheduleExactAlarm.isGranted;
    }
    return true;
  }

  // Check and request battery optimization exemption
  static Future<bool> checkBatteryOptimization() async {
    if (Platform.isAndroid) {
      // Check if battery optimization is ignored (which is what we want)
      final isIgnored = await Permission.ignoreBatteryOptimizations.isGranted;

      if (!isIgnored) {
        debugPrint('⚠️ Battery optimization is enabled - notifications may not work when app is closed');
        debugPrint('📱 Requesting battery optimization exemption...');

        // Request exemption - this will show a system dialog
        final status = await Permission.ignoreBatteryOptimizations.request();

        if (status.isGranted) {
          debugPrint('✅ Battery optimization exemption granted');
          return true;
        } else {
          debugPrint('❌ Battery optimization exemption denied - notifications may be delayed');
          return false;
        }
      }

      debugPrint('✅ Battery optimization already disabled for this app');
      return true;
    }
    return true;
  }

  // Schedule a test notification for 15 seconds from now
  static Future<void> scheduleTestNotification() async {
    if (!_initialized) await initialize();

    // Check battery optimization first
    await checkBatteryOptimization();

    // Check and request exact alarm permission first
    if (Platform.isAndroid && !await Permission.scheduleExactAlarm.isGranted) {
      debugPrint('❌ Exact alarm permission not granted. Requesting...');
      final granted = await requestExactAlarmPermission();
      if (!granted) {
        throw PlatformException(
          code: 'exact_alarms_not_permitted',
          message: 'Please enable exact alarms in app settings',
        );
      }
    }

    debugPrint('🔔 Scheduling test notification for 15 seconds from now...');

    // Also set a timer to show notification if app is still in foreground
    Future.delayed(const Duration(seconds: 15), () async {
      debugPrint('⏰ Checking if we need to manually show notification...');

      // Check if the scheduled notification is still pending
      final pending = await _notifications.pendingNotificationRequests();
      final stillPending = pending.any((n) => n.id == 999);

      if (!stillPending) {
        debugPrint('✅ Scheduled notification was already shown');
      } else {
        debugPrint('📱 App still in foreground, manually showing notification...');
        // The scheduled notification might not show if app is in foreground
        // So we manually show it
        await showTestNotificationNow();
      }
    });

    final androidDetails = AndroidNotificationDetails(
      'schuly_notifications_v2',
      'Schuly Benachrichtigungen',
      channelDescription: 'Benachrichtigungen vor Schulstunden',
      importance: Importance.max,
      priority: Priority.max,
      showWhen: true,
      playSound: true,
      enableVibration: true,
      vibrationPattern: _vibrationPattern,
      enableLights: true,
      ledColor: const Color.fromARGB(255, 255, 0, 0),
      ledOnMs: 1000,
      ledOffMs: 500,
      ticker: 'Test Notification',
      visibility: NotificationVisibility.public,
      category: AndroidNotificationCategory.alarm,
      autoCancel: true,
      icon: '@mipmap/ic_launcher',
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
      final now = DateTime.now();
      final scheduledDate = now.add(const Duration(seconds: 15));

      // Create TZDateTime from the scheduled date
      final tz.TZDateTime scheduledTZDate = tz.TZDateTime.from(scheduledDate, tz.local);

      debugPrint('Current time: ${now.toString()}');
      debugPrint('Scheduled for: ${scheduledDate.toString()}');
      debugPrint('TZ scheduled: ${scheduledTZDate.toString()}');

      await _notifications.zonedSchedule(
        999,
        '📚 Test: Upcoming Class',
        'Room: 203 • Teacher: Ms. Smith • This notification works even when app is closed!',
        scheduledTZDate,
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.alarmClock, // Better for Samsung
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        payload: 'test_notification',
      );

      debugPrint('✅ Test notification scheduled successfully');

      // Verify it was scheduled
      final pending = await _notifications.pendingNotificationRequests();
      final testNotification = pending.where((n) => n.id == 999).firstOrNull;
      if (testNotification != null) {
        debugPrint('✅ Verified: Test notification is in pending list');
      } else {
        debugPrint('⚠️ Warning: Test notification not found in pending list');
      }
    } catch (e) {
      debugPrint('❌ Failed to schedule test notification: $e');
      rethrow;
    }
  }

  // Check if notifications are actually enabled for the channel
  static Future<void> checkNotificationChannelStatus() async {
    if (Platform.isAndroid) {
      final plugin = _notifications
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();

      final channels = await plugin?.getNotificationChannels();
      if (channels != null) {
        for (final channel in channels) {
          debugPrint('📱 Channel: ${channel.id}');
          debugPrint('   - Name: ${channel.name}');
          debugPrint('   - Importance: ${channel.importance.name}');
          debugPrint('   - Sound: ${channel.sound?.sound}');
          debugPrint('   - Enable vibration: ${channel.enableVibration}');
          debugPrint('   - Show badge: ${channel.showBadge}');
        }
      }
    }
  }

  // Show test notification immediately (helper method)
  static Future<void> showTestNotificationNow() async {
    if (!_initialized) await initialize();

    // Check channel status first
    await checkNotificationChannelStatus();

    final androidDetails = AndroidNotificationDetails(
      'schuly_notifications_v2',
      'Schuly Benachrichtigungen',
      channelDescription: 'Benachrichtigungen vor Schulstunden',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      enableVibration: true,
      vibrationPattern: _vibrationPattern,
      icon: '@mipmap/ic_launcher',
      ticker: 'Scheduled Test Notification',
      visibility: NotificationVisibility.public,
      category: AndroidNotificationCategory.alarm,
      styleInformation: const BigTextStyleInformation(
        'This is a test notification that was scheduled 15 seconds ago. If you see this, scheduled notifications are working!',
        contentTitle: '📚 Test: Upcoming Class',
        summaryText: 'Schuly Notification Test',
      ),
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
        999,
        '📚 Test: Upcoming Class',
        'Room: 203 • Teacher: Ms. Smith • This was scheduled 15 seconds ago!',
        notificationDetails,
      );
      // Cancel the scheduled one since we showed it manually
      await _notifications.cancel(999);
      debugPrint('✅ Test notification shown manually (app was in foreground)');
    } catch (e) {
      debugPrint('❌ Failed to show test notification: $e');
    }
  }

  // Show a test notification
  static Future<void> showTestNotification() async {
    if (!_initialized) await initialize();

    debugPrint('🔔 Showing simple test notification...');

    // Try the simplest possible notification
    const androidDetails = AndroidNotificationDetails(
      'schuly_test_v2',
      'Schuly Test',
      importance: Importance.max,
      priority: Priority.max,
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
      // Try showing multiple notifications with different IDs to see if any appear
      await _notifications.show(
        DateTime.now().millisecondsSinceEpoch % 100000, // Random ID
        'Schuly Test',
        'If you see this, notifications are working!',
        notificationDetails,
      );
      debugPrint('✅ Simple test notification sent');

      // Also try with the Android system notification API directly
      await _notifications.show(
        DateTime.now().millisecondsSinceEpoch % 100000 + 1,
        'Test 2',
        'Testing notification visibility',
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'default',
            'Default Channel',
            importance: Importance.max,
            priority: Priority.max,
          ),
        ),
      );
      debugPrint('✅ Second test notification sent');
    } catch (e) {
      debugPrint('❌ Failed to show test notification: $e');
    }
  }
}