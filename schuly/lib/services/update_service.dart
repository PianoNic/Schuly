import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_file/open_file.dart';

class UpdateService {
  static const String _repoUrl = 'https://api.github.com/repos/PianoNic/Schuly/releases/latest';

  /// Check if there's a newer version available
  static Future<UpdateInfo?> checkForUpdates() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = packageInfo.version;

      final response = await http.get(Uri.parse(_repoUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final latestVersion = data['tag_name'] as String;
        final releaseNotes = data['body'] as String;
        final assets = data['assets'] as List;

        // Find the APK asset
        String? apkDownloadUrl;
        for (var asset in assets) {
          final assetName = asset['name'] as String;
          if (assetName.endsWith('.apk')) {
            apkDownloadUrl = asset['browser_download_url'] as String;
            break;
          }
        }

        if (apkDownloadUrl == null) {
          return null; // No APK found in release
        }

        // Compare versions
        if (_isNewerVersion(latestVersion, currentVersion)) {
          return UpdateInfo(
            currentVersion: currentVersion,
            latestVersion: latestVersion,
            downloadUrl: apkDownloadUrl,
            releaseNotes: releaseNotes,
          );
        }
      }
    } catch (e) {
      print('Error checking for updates: $e');
    }
    return null;
  }

  /// Compare two version strings (e.g., "v0.4.0" vs "v0.3.0")
  static bool _isNewerVersion(String latestVersion, String currentVersion) {
    // Remove 'v' prefix if present
    final latest = latestVersion.replaceFirst('v', '');
    final current = currentVersion.replaceFirst('v', '');

    final latestParts = latest.split('.').map(int.parse).toList();
    final currentParts = current.split('.').map(int.parse).toList();

    // Ensure both have same number of parts
    while (latestParts.length < currentParts.length) {
      latestParts.add(0);
    }
    while (currentParts.length < latestParts.length) {
      currentParts.add(0);
    }

    for (int i = 0; i < latestParts.length; i++) {
      if (latestParts[i] > currentParts[i]) return true;
      if (latestParts[i] < currentParts[i]) return false;
    }
    return false;
  }

  /// Download APK with progress callback
  static Future<String?> downloadApk(
    String downloadUrl,
    String version,
    void Function(double progress)? onProgress,
  ) async {
    try {
      final dio = Dio();
      final tempDir = await getTemporaryDirectory();
      final filePath = '${tempDir.path}/schuly-$version.apk';

      await dio.download(
        downloadUrl,
        filePath,
        onReceiveProgress: (received, total) {
          if (total > 0 && onProgress != null) {
            final progress = received / total;
            onProgress(progress);
          }
        },
      );

      return filePath;
    } catch (e) {
      print('Error downloading APK: $e');
      return null;
    }
  }

  /// Check and request install permission
  static Future<bool> checkInstallPermission() async {
    if (Platform.isAndroid) {
      final permission = Permission.requestInstallPackages;
      final status = await permission.status;

      if (status != PermissionStatus.granted) {
        final result = await permission.request();
        return result == PermissionStatus.granted;
      }
      return true;
    }
    return false;
  }

  /// Install APK file using OpenFile to trigger Android's package installer
  static Future<bool> installApk(String filePath) async {
    try {
      if (Platform.isAndroid) {
        final result = await OpenFile.open(filePath);
        // OpenFile returns different result types, check if it's successful
        return result.type == ResultType.done;
      }
    } catch (e) {
      print('Error installing APK: $e');
    }
    return false;
  }
}

class UpdateInfo {
  final String currentVersion;
  final String latestVersion;
  final String downloadUrl;
  final String releaseNotes;

  UpdateInfo({
    required this.currentVersion,
    required this.latestVersion,
    required this.downloadUrl,
    required this.releaseNotes,
  });
}