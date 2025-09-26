@echo off
echo Building Schuly PROD flavor...
flutter build apk --flavor prod --release
echo.
echo Build complete! APK location:
echo build\app\outputs\flutter-apk\app-prod-release.apk