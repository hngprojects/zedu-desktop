import 'package:flutter_starter/features/auth/data/models/organisation_plan_model.dart';
import 'package:flutter_starter/features/auth/data/models/user_role_model.dart';

class OrganisationModel {
  const OrganisationModel({
    required this.id,
    required this.name,
    required this.description,
    required this.email,
    required this.type,
    required this.location,
    required this.country,
    required this.ownerId,
    required this.logoUrl,
    required this.creditBalance,
    required this.channelsCount,
    required this.totalMessagesCount,
    required this.orgRoles,
    required this.pinned,
    required this.users,
    required this.createdAt,
    required this.updatedAt,
    required this.channels,
    required this.subscriptionPlanId,
    required this.stripeCustomerId,
    required this.orgPlanId,
    required this.organisationPlan,
    required this.organisationSlug,
    required this.userRole,
  });

  final String id;
  final String name;
  final String description;
  final String email;
  final String type;
  final String location;
  final String country;
  final String ownerId;
  final String logoUrl;
  final int creditBalance;
  final int channelsCount;
  final int totalMessagesCount;
  final List<dynamic> orgRoles;
  final bool pinned;
  final dynamic users;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic channels;
  final String subscriptionPlanId;
  final String stripeCustomerId;
  final String orgPlanId;
  final OrganisationPlanModel organisationPlan;
  final String organisationSlug;
  final UserRoleModel userRole;

  factory OrganisationModel.fromJson(Map<String, dynamic> json) {
    return OrganisationModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      email: json['email'] as String,
      type: json['type'] as String,
      location: json['location'] as String,
      country: json['country'] as String,
      ownerId: json['owner_id'] as String,
      logoUrl: json['logo_url'] as String,
      creditBalance: json['credit_balance'] as int,
      channelsCount: json['channels_count'] as int,
      totalMessagesCount: json['total_messages_count'] as int,
      orgRoles: json['org_roles'] as List<dynamic>,
      pinned: json['pinned'] as bool,
      users: json['Users'],
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      channels: json['channels'],
      subscriptionPlanId: json['subscription_plan_id'] as String,
      stripeCustomerId: json['stripe_customer_id'] as String,
      orgPlanId: json['org_plan_id'] as String,
      organisationPlan: OrganisationPlanModel.fromJson(
        json['organisation_plan'] as Map<String, dynamic>,
      ),
      organisationSlug: json['organisation_slug'] as String,
      userRole: UserRoleModel.fromJson(
        json['user_role'] as Map<String, dynamic>,
      ),
    );
  }
}
