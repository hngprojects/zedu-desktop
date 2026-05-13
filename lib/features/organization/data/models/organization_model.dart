import 'package:zedu/features/features.dart';


class OrganizationModel extends Organization {
  const OrganizationModel({
    required super.id,
    required super.name,
    required super.description,
    required super.email,
    required super.country,
    required super.industry,
    required super.location,
    required super.ownerId,
    required super.logoUrl,
    required super.channelsCount,
    required super.totalMessagesCount,
    required super.userRole,
    required super.organizationPlan,
    required super.createdAt,
    required super.updatedAt,
  });

  factory OrganizationModel.fromJson(Map<String, dynamic> json) {
    return OrganizationModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      email: json['email'] as String,
      country: json['country'] as String,
      industry: json['industry'] as String,
      location: json['location'] as String,
      ownerId: json['owner_id'] as String,
      logoUrl: json['logo_url'] as String,
      channelsCount: json['channels_count'] as int,
      totalMessagesCount: json['total_messages_count'] as int,
      userRole: json['user_role'] as String,
      organizationPlan: OrganizationPlanModel.fromJson(
        json['organisation_plan'] as Map<String, dynamic>,
      ),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'email': email,
      'country': country,
      'industry': industry,
      'location': location,
      'owner_id': ownerId,
      'logo_url': logoUrl,
      'channels_count': channelsCount,
      'total_messages_count': totalMessagesCount,
      'user_role': userRole,
      'organisation_plan': (organizationPlan as OrganizationPlanModel).toJson(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
