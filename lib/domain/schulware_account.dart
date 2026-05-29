import 'package:schuly_api/schuly_api.dart';

import '../config/oidc_config.dart';

/// A school the signed-in user belongs to, from `GET /api/schools/my-schools`.
/// Carries the school name plus the user's identity (full name + email) at
/// that school — what the account switcher displays. [provider] is inferred
/// from which plugin owns the school's SchoolUser (the API doesn't expose it).
class MySchool {
  final String id;
  final String name;
  final String? email;
  final String? fullName;
  final String provider; // 'schulnetz' | 'odaorg'
  /// The plugin account id backing this school (for triggering a sync).
  final String? pluginAccountId;
  /// Backend-supplied, fully-resolved URLs (null if not provided).
  final String? logoUrl;
  final String? profilePictureUrl;

  const MySchool({
    required this.id,
    required this.name,
    this.email,
    this.fullName,
    this.provider = 'schulnetz',
    this.pluginAccountId,
    this.logoUrl,
    this.profilePictureUrl,
  });

  factory MySchool.fromDto(
    MySchoolDto dto, {
    String provider = 'schulnetz',
    String? pluginAccountId,
  }) =>
      MySchool(
        id: dto.id ?? '',
        name: (dto.name?.isNotEmpty ?? false) ? dto.name! : 'School',
        email: dto.email,
        fullName: dto.fullName,
        provider: provider,
        pluginAccountId: pluginAccountId,
        logoUrl: OidcConfig.resolveUrl(dto.logoUrl),
        profilePictureUrl: OidcConfig.resolveUrl(dto.profilePictureUrl),
      );

  /// Fallback asset for this provider's logo when [logoUrl] is null.
  String get logoAsset => switch (provider) {
        'odaorg' => 'assets/schoolsystems/odaorg.webp',
        _ => 'assets/schoolsystems/schulnetz.webp',
      };
}
