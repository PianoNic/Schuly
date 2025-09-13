import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import '../models/release_note.dart';
import 'storage_service.dart';

class ReleaseNotesService {
  static const String _lastShownVersionKey = 'last_shown_release_notes_version';
  static const String _releaseNotesSeenKey = 'release_notes_seen_versions';
  static const String _cacheKey = 'cached_release_notes';
  static const String _cacheTimestampKey = 'cache_timestamp';
  
  // GitHub repository info
  static const String _githubOwner = 'PianoNic';
  static const String _githubRepo = 'schuly';
  static const Duration _cacheExpiry = Duration(hours: 1);
  
  static List<ReleaseNote>? _cachedReleaseNotes;

  /// Fetch release notes from GitHub API
  static Future<List<ReleaseNote>> _fetchReleaseNotesFromGitHub() async {
    try {
      final url = 'https://api.github.com/repos/$_githubOwner/$_githubRepo/releases';
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/vnd.github.v3+json',
          'User-Agent': 'Schuly-App',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> releasesJson = jsonDecode(response.body);
        return releasesJson.map((json) => _parseGitHubRelease(json)).toList();
      } else {
        throw Exception('Failed to fetch releases: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching release notes: $e');
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
      description: json['body'] ?? '', // Store raw markdown
      features: [], // No longer parsing into structured lists
      bugFixes: [],
      improvements: [],
      isImportant: json['prerelease'] == false && !version.contains('beta') && !version.contains('alpha'),
    );
  }

  /// Get all release notes sorted by version (newest first)
  static Future<List<ReleaseNote>> getAllReleaseNotes() async {
    if (_cachedReleaseNotes != null) {
      return List.from(_cachedReleaseNotes!)..sort((a, b) => b.version.compareTo(a.version));
    }

    // Check cache first
    final cachedNotes = await _getCachedReleaseNotes();
    if (cachedNotes != null) {
      _cachedReleaseNotes = cachedNotes;
      return List.from(cachedNotes)..sort((a, b) => b.version.compareTo(a.version));
    }

    // Fetch from GitHub
    try {
      final notes = await _fetchReleaseNotesFromGitHub();
      _cachedReleaseNotes = notes;
      await _cacheReleaseNotes(notes);
      return List.from(notes)..sort((a, b) => b.version.compareTo(a.version));
    } catch (e) {
      // Return empty list if fetch fails
      return [];
    }
  }

  /// Get release notes for versions newer than the last shown version
  static Future<List<ReleaseNote>> getNewReleaseNotes() async {
    final allNotes = await getAllReleaseNotes();
    final lastShownVersion = await _getLastShownVersion();
    final currentVersion = await _getCurrentVersion();
    
    return allNotes.where((note) {
      return _isVersionNewer(note.version, lastShownVersion) &&
             !_isVersionNewer(note.version, currentVersion);
    }).toList()..sort((a, b) => b.version.compareTo(a.version));
  }

  /// Check if there are new release notes to show
  static Future<bool> hasNewReleaseNotes() async {
    final newNotes = await getNewReleaseNotes();
    return newNotes.isNotEmpty;
  }

  /// Mark release notes as seen for the current version
  static Future<void> markReleaseNotesAsSeen() async {
    final currentVersion = await _getCurrentVersion();
    await StorageService.setString(_lastShownVersionKey, currentVersion);
    
    // Also track individual version as seen
    final seenVersions = await _getSeenVersions();
    if (!seenVersions.contains(currentVersion)) {
      seenVersions.add(currentVersion);
      await StorageService.setString(_releaseNotesSeenKey, jsonEncode(seenVersions));
    }
  }

  /// Get release note for a specific version
  static Future<ReleaseNote?> getReleaseNoteForVersion(String version) async {
    final allNotes = await getAllReleaseNotes();
    try {
      return allNotes.firstWhere((note) => note.version == version);
    } catch (e) {
      return null;
    }
  }

  /// Cache release notes to local storage
  static Future<void> _cacheReleaseNotes(List<ReleaseNote> notes) async {
    final jsonList = notes.map((note) => note.toJson()).toList();
    await StorageService.setString(_cacheKey, jsonEncode(jsonList));
    await StorageService.setString(_cacheTimestampKey, DateTime.now().millisecondsSinceEpoch.toString());
  }

  /// Get cached release notes if not expired
  static Future<List<ReleaseNote>?> _getCachedReleaseNotes() async {
    final cachedJson = await StorageService.getString(_cacheKey);
    final timestampStr = await StorageService.getString(_cacheTimestampKey);
    
    if (cachedJson == null || timestampStr == null) return null;
    
    try {
      final timestamp = DateTime.fromMillisecondsSinceEpoch(int.parse(timestampStr));
      if (DateTime.now().difference(timestamp) > _cacheExpiry) {
        return null; // Cache expired
      }
      
      final List<dynamic> jsonList = jsonDecode(cachedJson);
      return jsonList.map((json) => ReleaseNote.fromJson(json)).toList();
    } catch (e) {
      return null;
    }
  }

  /// Clear cached release notes (useful for testing or forcing refresh)
  static Future<void> clearCache() async {
    // Use the underlying storage's delete method
    const storage = FlutterSecureStorage();
    await storage.delete(key: _cacheKey);
    await storage.delete(key: _cacheTimestampKey);
    _cachedReleaseNotes = null;
  }

  /// Check if should show release notes on app start
  static Future<bool> shouldShowReleaseNotesOnStart() async {
    final hasNew = await hasNewReleaseNotes();
    return hasNew; // Show every time until user confirms
  }

  // Private helper methods
  static Future<String> _getCurrentVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  static Future<String> _getLastShownVersion() async {
    return await StorageService.getString(_lastShownVersionKey) ?? '0.0.0';
  }

  static Future<List<String>> _getSeenVersions() async {
    final seenJson = await StorageService.getString(_releaseNotesSeenKey);
    if (seenJson == null) return [];
    
    try {
      final List<dynamic> decoded = jsonDecode(seenJson);
      return decoded.map((e) => e.toString()).toList();
    } catch (e) {
      return [];
    }
  }

  static bool _isVersionNewer(String version1, String version2) {
    final v1Parts = version1.split('.').map(int.parse).toList();
    final v2Parts = version2.split('.').map(int.parse).toList();
    
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