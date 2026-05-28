/// Light view of a Schulware-plugin account row. The backend's swagger
/// declares the list response as `void`, so we narrow the raw JSON map at
/// the boundary instead of through generated DTOs.
class SchulwareAccount {
  final String id;
  final String displayName;
  final String schulnetzBaseUrl;

  const SchulwareAccount({
    required this.id,
    required this.displayName,
    required this.schulnetzBaseUrl,
  });

  factory SchulwareAccount.fromJson(Map<String, dynamic> json) => SchulwareAccount(
        id: json['id'] as String,
        displayName: (json['displayName'] as String?) ?? 'Untitled',
        schulnetzBaseUrl: (json['schulnetzBaseUrl'] as String?) ?? '',
      );
}
