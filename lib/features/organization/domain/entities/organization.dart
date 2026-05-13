import 'package:zedu/features/features.dart';

class Organization {
  const Organization({
    required this.id,
    required this.name,
    required this.description,
    required this.email,
    required this.country,
    required this.industry,
    required this.location,
    required this.ownerId,
    required this.logoUrl,
    required this.channelsCount,
    required this.totalMessagesCount,
    required this.userRole,
    required this.organizationPlan,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String name;
  final String description;
  final String email;
  final String country;
  final String industry;
  final String location;
  final String ownerId;
  final String logoUrl;
  final int channelsCount;
  final int totalMessagesCount;
  final String userRole;
  final OrganizationPlan organizationPlan;
  final DateTime createdAt;
  final DateTime updatedAt;
}
