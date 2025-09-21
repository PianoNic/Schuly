# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Schuly is a Flutter mobile application that serves as a client for a school management system. It provides students with access to grades, absences, agenda/schedule, and account management through a mobile-friendly interface.

## Error Tracking

### GlitchTip/Sentry Integration
The app is integrated with GlitchTip for error tracking and monitoring:
- **DSN**: Configured via GitHub Actions repository variable `SENTRY_URL`
- **Automatic error capture**: All unhandled Flutter and Dart errors are captured
- **User context**: Tracks user email and authentication type
- **API error handling**: Specific handling for network and API errors
- **Breadcrumbs**: Navigation and action tracking for better debugging
- **Status Badge**: Shows in app settings when error tracking is active

### CI/CD Configuration
The GlitchTip DSN is automatically injected during release builds:
- GitHub repository variable: `SENTRY_URL`
- Applied in `build-and-release.yml` workflow
- Release version automatically set from git tag
- Environment set to "production" for releases

### Local Development
For local development with error tracking:
```bash
# Set environment variable first
export SENTRY_DSN="your_dsn_here"

# Then run Flutter
flutter run --dart-define=SENTRY_DSN="$SENTRY_DSN" --dart-define=SENTRY_RELEASE="dev" --dart-define=SENTRY_ENVIRONMENT="development"
```

### Testing Error Tracking
1. **In-App Test Button**: Settings → About App → Test Error Tracking
   - Only visible when error tracking is enabled
   - Can be triggered once every 30 seconds
   - Shows countdown timer during cooldown period
   - Sends a test exception directly to GlitchTip

2. **Programmatic Testing**: Use `TestErrors.triggerTestException()` in code
3. **Status Badge**: Green "Error Tracking" badge appears in Settings → About App when enabled

## Development Commands

### Flutter Commands
- **Run app**: `flutter run` (or `flutter run -d chrome` for web)
- **Build APK**: `flutter build apk`
- **Build iOS**: `flutter build ios`
- **Hot reload**: `r` in terminal while running, or save files in IDE
- **Install dependencies**: `flutter pub get`
- **Clean build**: `flutter clean`
- **Analyze code**: `flutter analyze` 
- **Run tests**: `flutter test`
- **Update app icon**: `dart run flutter_launcher_icons`

### Code Quality
- Lint configuration is in `analysis_options.yaml`
- Uses `package:flutter_lints/flutter.yaml` for recommended lints
- Run `flutter analyze` to check for issues before committing

## Architecture

### State Management
- **Provider pattern** for global state management
- Key providers:
  - `ApiStore` (`lib/providers/api_store.dart`): Manages API authentication, user sessions, data fetching, and navigation state (e.g., selected absence ID)
  - `ThemeProvider` (`lib/providers/theme_provider.dart`): Handles theme mode and seed color preferences

### Authentication & Storage
- **Multi-user support**: Users can switch between multiple accounts
- **Token management**: Bearer tokens with auto-refresh on expiration
- **Secure storage**: Uses `flutter_secure_storage` for storing sensitive data (tokens, user credentials)
- **API base URL**: Configurable at runtime, stored securely

### API Integration
- **Generated API client**: Located in `lib/api/` (auto-generated from OpenAPI spec)
- **Main APIs**: 
  - `AuthorizationApi`: Authentication endpoints
  - `MobileAPIApi`: Core mobile app endpoints
- **Data models**: Auto-generated DTOs in `lib/api/lib/model/`

### Navigation Structure
- **Bottom navigation** with 5 main sections:
  1. **Start** (`lib/pages/start_page.dart`): Dashboard/overview
  2. **Agenda** (`lib/pages/agenda_page.dart`): Schedule/calendar
  3. **Noten** (`lib/pages/notes_page.dart`): Grades
  4. **Absences** (`lib/pages/absences_page.dart`): Absences
  5. **Account** (`lib/pages/account_page.dart`): User settings and management

### Key Features
- **Material 3 theming** with custom seed colors
- **Multi-platform support**: Android, iOS, Web (via Flutter)
- **Offline capability**: Data cached via ApiStore
- **Student ID card**: Integrated student identification
- **Theme customization**: Light/dark mode with custom colors
- **Absence management**: Expandable absence cards with integrated notices
- **Smart navigation**: Auto-expansion when navigating from start page to specific absences

### Code Organization
```
lib/
├── api/                    # Generated API client (auto-generated)
├── pages/                  # Screen/page widgets
├── providers/              # State management (Provider pattern)
├── widgets/                # Reusable UI components
├── utils/                  # Utility functions
└── main.dart              # App entry point
```

### Dependencies
- **Core**: `flutter`, `provider` (state management)
- **HTTP**: `http` package via generated API client
- **Storage**: `flutter_secure_storage`
- **UI**: `webview_flutter`, Material 3 theming
- **Development**: `flutter_lints`, `flutter_launcher_icons`

## Important Notes
- The API client in `lib/api/` is auto-generated - avoid manual edits
- Authentication uses bearer tokens with automatic refresh
- All sensitive data (tokens, passwords) stored in secure storage
- Multi-user functionality allows switching between accounts
- Theme preferences persist across app sessions