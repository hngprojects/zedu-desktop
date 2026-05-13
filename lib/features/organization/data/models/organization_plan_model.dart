import 'package:zedu/features/features.dart';

class OrganizationPlanModel extends OrganizationPlan {
  const OrganizationPlanModel({
    required super.id,
    required super.organizationId,
    required super.planId,
    required super.startedAt,
    required super.endedAt,
    required super.status,
    required super.sessionId,
    required super.invoicePdfUrl,
    required super.createdAt,
    required super.updatedAt,
    required super.planDetails,
  });

  factory OrganizationPlanModel.fromJson(Map<String, dynamic> json) {
    return OrganizationPlanModel(
      id: json['id'] as String,
      organizationId: json['organisation_id'] as String,
      planId: json['plan_id'] as String,
      startedAt: DateTime.parse(json['started_at'] as String),
      endedAt: DateTime.parse(json['ended_at'] as String),
      status: json['status'] as String,
      sessionId: json['session_id'] as String,
      invoicePdfUrl: json['invoice_pdf_url'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      planDetails: OrganizationPlanDetailsModel.fromJson(
        json['plan_details'] as Map<String, dynamic>,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'organisation_id': organizationId,
      'plan_id': planId,
      'started_at': startedAt.toIso8601String(),
      'ended_at': endedAt.toIso8601String(),
      'status': status,
      'session_id': sessionId,
      'invoice_pdf_url': invoicePdfUrl,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'plan_details': (planDetails as OrganizationPlanDetailsModel).toJson(),
    };
  }
}
