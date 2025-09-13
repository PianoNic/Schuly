import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:open_file/open_file.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../models/release_note.dart';
import 'storage_service.dart';

class AppUpdateService {
  static const String _githubOwner = 'PianoNic';
  static const String _githubRepo = 'schuly';
  static const String _dismissedVersionKey = 'dismissed_update_version';
  
  static final Dio _dio = Dio();

  /// Check if a new version is available on GitHub
  static Future<ReleaseNote?> checkForUpdates() async {
    try {
      final currentVersion = await _getCurrentVersion();
      final latestRelease = await _getLatestGitHubRelease();
      
      if (latestRelease == null) return null;
      
      // Check if this version is newer than current
      if (_isVersionNewer(latestRelease.version, currentVersion)) {
        // Check if user has dismissed this version
        final dismissedVersion = await StorageService.getString(_dismissedVersionKey);
        if (dismissedVersion != latestRelease.version) {
          return latestRelease;
        }
      }
      
      return null;
    } catch (e) {
      if (kDebugMode) {
        print('Error checking for updates: $e');
      }
      return null;
    }
  }

  /// Get the latest release from GitHub
  static Future<ReleaseNote?> _getLatestGitHubRelease() async {
    try {
      final url = 'https://api.github.com/repos/$_githubOwner/$_githubRepo/releases/latest';
      final response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Accept': 'application/vnd.github.v3+json',
            'User-Agent': 'Schuly-App',
          },
        ),
      );

      if (response.statusCode == 200) {
        final json = response.data as Map<String, dynamic>;
        return _parseGitHubRelease(json);
      }
      
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Parse GitHub release JSON to ReleaseNote object
  static ReleaseNote _parseGitHubRelease(Map<String, dynamic> json) {
    final tagName = json['tag_name'] as String? ?? '';
    final version = tagName.startsWith('v') ? tagName.substring(1) : tagName;
    
    return ReleaseNote(
      version: version,
      releaseDate: DateTime.parse(json['published_at'] ?? DateTime.now().toIso8601String()),
      title: json['name'] ?? 'Release $version',
      description: json['body'] ?? '',
      features: [],
      bugFixes: [],
      improvements: [],
      isImportant: true, // All app updates are important
    );
  }

  /// Download and install the APK
  static Future<bool> downloadAndInstallUpdate(ReleaseNote release) async {
    try {
      // Request storage permission
      final storagePermission = await Permission.storage.request();
      if (!storagePermission.isGranted) {
        return false;
      }

      // Get the APK download URL from GitHub release
      final downloadUrl = await _getApkDownloadUrl(release);
      if (downloadUrl == null) {
        return false;
      }

      // Download the APK
      final apkFile = await _downloadApk(downloadUrl, release.version);
      if (apkFile == null) {
        return false;
      }

      // Install the APK
      await _installApk(apkFile);
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Error downloading/installing update: $e');
      }
      return false;
    }
  }

  /// Get APK download URL from GitHub release
  static Future<String?> _getApkDownloadUrl(ReleaseNote release) async {
    try {
      final url = 'https://api.github.com/repos/$_githubOwner/$_githubRepo/releases/tags/v${release.version}';
      final response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Accept': 'application/vnd.github.v3+json',
            'User-Agent': 'Schuly-App',
          },
        ),
      );

      if (response.statusCode == 200) {
        final json = response.data as Map<String, dynamic>;
        final assets = json['assets'] as List<dynamic>?;
        
        if (assets != null) {
          // Look for APK file in assets
          for (final asset in assets) {
            final name = asset['name'] as String?;
            if (name != null && name.toLowerCase().endsWith('.apk')) {
              return asset['browser_download_url'] as String?;
            }
          }
        }
      }
      
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Download APK file
  static Future<File?> _downloadApk(String downloadUrl, String version) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final filePath = '${tempDir.path}/schuly_v$version.apk';
      
      await _dio.download(
        downloadUrl,
        filePath,
        options: Options(
          followRedirects: true,
          maxRedirects: 5,
        ),
      );
      
      return File(filePath);
    } catch (e) {
      return null;
    }
  }

  /// Install APK file
  static Future<void> _installApk(File apkFile) async {
    await OpenFile.open(apkFile.path);
  }

  /// Mark update as dismissed for this version
  static Future<void> dismissUpdate(String version) async {
    await StorageService.setString(_dismissedVersionKey, version);
  }

  /// Clear dismissed version (for testing)
  static Future<void> clearDismissedVersion() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: _dismissedVersionKey);
  }

  // Helper methods
  static Future<String> _getCurrentVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  static bool _isVersionNewer(String version1, String version2) {
    final v1Parts = version1.split('.').map((e) => int.tryParse(e) ?? 0).toList();
    final v2Parts = version2.split('.').map((e) => int.tryParse(e) ?? 0).toList();
    
    // Pad shorter version with zeros
    while (v1Parts.length < 3) {
      v1Parts.add(0);
    }
    while (v2Parts.length < 3) {
      v2Parts.add(0);
    }
    
    for (int i = 0; i < 3; i++) {
      if (v1Parts[i] > v2Parts[i]) return true;
      if (v1Parts[i] < v2Parts[i]) return false;
    }
    
    return false; // Equal versions
  }
}