import 'package:schuly_api/schuly_api.dart';

/// A school the signed-in user belongs to, from `GET /api/schools/my-schools`.
/// Carries the school name plus the user's identity (full name + email) at
/// that school — what the account switcher displays.
class MySchool {
  final String id;
  final String name;
  final String? email;
  final String? fullName;

  const MySchool({
    required this.id,
    required this.name,
    this.email,
    this.fullName,
  });

  factory MySchool.fromDto(MySchoolDto dto) => MySchool(
        id: dto.id ?? '',
        name: (dto.name?.isNotEmpty ?? false) ? dto.name! : 'School',
        email: dto.email,
        fullName: dto.fullName,
      );
}
