# <p align="center">Schuly</p>
<p align="center">
  <img src="./assets/app_icon.png" width="200" alt="Schuly Logo">
</p>
<p align="center">
  <strong>Schuly, the better Schulnetz app</strong>
</p>
<p align="center">
  <a href="https://github.com/PianoNic/Schuly"><img src="https://badgetrack.pianonic.ch/badge?tag=schuly&label=visits&color=3da8ff&style=flat" alt="visits"/></a>
  <a href="https://github.com/PianoNic/Schuly/blob/main/LICENSE"><img src="https://img.shields.io/github/license/PianoNic/Schuly?color=3da8ff"/></a>
  <a href="https://github.com/PianoNic/Schuly/releases"><img src="https://img.shields.io/github/v/release/PianoNic/Schuly?include_prereleases&color=3da8ff&label=Latest%20Release"/></a>
  <a href="#-installation"><img src="https://img.shields.io/badge/Selfhost-Instructions-3da8ff.svg"/></a>
</p>

Schuly is a modern mobile application that provides a superior alternative to the official Schulnetz app. Built for students, it offers seamless access to grades, schedules, absences, and account management with an intuitive, Material 3-designed interface.

The app connects to **[SchulwareAPI](https://github.com/PianoNic/SchulwareAPI)**, a unified API that simplifies data access from Schulnetz systems through dynamic routing and supports both mobile REST endpoints and web scraping.

## ✨ Features

- **📱 Multi-platform**: Android, iOS, and Web support
- **📊 Grades**: View and track your academic performance
- **📅 Agenda**: Access your schedule and upcoming events
- **🏃 Absences**: Monitor attendance and absence records
- **👤 Account Management**: Multi-user support with secure authentication
- **🎨 Theming**: Material 3 design with custom colors and dark/light mode
- **🔔 Notifications**: Push notifications for important updates
- **🆔 Student ID**: Integrated digital student identification card
- **🔒 Secure**: Uses secure storage for sensitive data and tokens
- **🌐 Configurable**: Runtime-configurable API base URL

## 📱 Installation

### Download from Releases

The easiest way to install Schuly is to download the latest version from the **[Releases tab](https://github.com/PianoNic/Schuly/releases)** on GitHub.

**Available formats:**
- **Android**: Download the `.apk` file
- **iOS**: Download the `.ipa` file (requires sideloading)
- **Web**: Access the web version directly

### Building from Source

**Prerequisites:**
- SDK (^3.9.0)
- Android Studio / Xcode (for mobile development)

**Steps:**
```bash
# Clone the repository
git clone https://github.com/PianoNic/Schuly.git
cd Schuly/schuly

# Install dependencies
pub get

# Run the app
run

# Build for production
build apk          # Android
build ios          # iOS
build web          # Web
```

## 🚀 Development

### Key Technologies
- **Cross-platform UI framework**
- **Provider**: State management
- **Material 3**: Modern design system
- **Secure Storage**: Encrypted local storage
- **HTTP**: API communication
- **WebView**: Embedded web content

### Development Commands
```bash
# Install dependencies
pub get

# Run app (debug mode)
run

# Hot reload (while running)
r

# Code analysis
analyze

# Run tests
test

# Update app icon
dart run flutter_launcher_icons

# Clean build
clean
```

## 🔧 Configuration

### API Setup
1. Launch the app
2. Go to Account settings
3. Configure your SchulwareAPI base URL (or use the default hosted instance)
4. Login with your Schulnetz credentials

### Backend Requirements
Schuly requires a **[SchulwareAPI](https://github.com/PianoNic/SchulwareAPI)** instance to function. You can either:
- Use the default hosted instance (recommended for most users)
- Self-host your own SchulwareAPI instance using Docker
- Configure a custom API endpoint in the app settings

### Multi-User Support
Schuly supports multiple user accounts:
- Switch between accounts seamlessly
- Secure token management per user
- Independent settings per account

## 🎨 Customization

### Themes
- **Material 3** design with dynamic colors
- **Light/Dark mode** support
- **Custom seed colors** for personalization
- **System theme** detection

### Localization
- Multi-language support via internationalization
- Custom localizations for specific features

## 🔒 Security

- **Secure Storage**: All sensitive data encrypted locally
- **Token Management**: Automatic token refresh and secure storage
- **API Security**: Bearer token authentication
- **Multi-User Privacy**: Isolated data per user account

## 📄 License

This project is licensed under the terms specified in the [LICENSE](LICENSE) file.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📞 Support

For issues, feature requests, or questions, please visit the **[Issues](https://github.com/PianoNic/Schuly/issues)** section on GitHub.

---
<p align="center">Made with ❤️ by <a href="https://github.com/Pianonic">Pianonic</a></p>
