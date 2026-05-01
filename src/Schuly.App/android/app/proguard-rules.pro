# Flutter Local Notifications
-keep class com.dexterous.** { *; }
-keep class androidx.core.app.NotificationCompat { *; }
-keep class androidx.core.app.NotificationCompat$* { *; }

# Timezone
-keep class com.google.android.gms.** { *; }
-keep class net.fortuna.ical4j.** { *; }
-keep class org.apache.commons.** { *; }

# Keep notification channels
-keep class android.app.NotificationChannel { *; }
-keep class android.app.NotificationChannelGroup { *; }

# Permission handler
-keep class com.baseflow.permissionhandler.** { *; }

# Keep all notification related classes
-keepattributes *Annotation*
-keepattributes Signature
-keepattributes Exceptions

# Keep Flutter plugins
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Keep alarm manager related classes
-keep class android.app.AlarmManager { *; }
-keep class android.app.PendingIntent { *; }
-keep class android.content.Intent { *; }

# Keep broadcast receivers
-keep public class * extends android.content.BroadcastReceiver
-keep public class * extends android.app.Service
-keep public class * extends android.app.Activity