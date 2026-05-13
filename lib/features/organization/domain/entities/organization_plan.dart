import 'plan_details.dart';

class OrganizationPlan {
  const OrganizationPlan({
    required this.id,
    required this.organizationId,
    required this.planId,
    required this.startedAt,
    required this.endedAt,
    required this.status,
    required this.sessionId,
    required this.invoicePdfUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.planDetails,
  });

  final String id;
  final String organizationId;
  final String planId;
  final DateTime startedAt;
  final DateTime endedAt;
  final String status;
  final String sessionId;
  final String invoicePdfUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final PlanDetails planDetails;
}
