@echo off
echo Building Schuly DEV flavor...
flutter build apk --flavor dev --debug --dart-define=SENTRY_DSN=%SENTRY_DSN% --dart-define=SENTRY_RELEASE=dev --dart-define=SENTRY_ENVIRONMENT=development
echo.
echo Build complete! APK location:
echo build\app\outputs\flutter-apk\app-dev-debug.apk