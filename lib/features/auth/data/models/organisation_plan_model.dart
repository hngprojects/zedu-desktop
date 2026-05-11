import 'package:zedu/features/auth/data/models/plan_details_model.dart';

class OrganisationPlanModel {
  const OrganisationPlanModel({
    required this.startedAt,
    required this.endedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.planDetails,
  });

  final DateTime startedAt;
  final DateTime endedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final PlanDetailsModel planDetails;

  factory OrganisationPlanModel.fromJson(Map<String, dynamic> json) {
    return OrganisationPlanModel(
      startedAt: DateTime.parse(
        json['started_at'] as String? ?? '0001-01-01T00:00:00Z',
      ),
      endedAt: DateTime.parse(
        json['ended_at'] as String? ?? '0001-01-01T00:00:00Z',
      ),
      createdAt: DateTime.parse(
        json['created_at'] as String? ?? '0001-01-01T00:00:00Z',
      ),
      updatedAt: DateTime.parse(
        json['updated_at'] as String? ?? '0001-01-01T00:00:00Z',
      ),
      planDetails: PlanDetailsModel.fromJson(
        json['plan_details'] as Map<String, dynamic>,
      ),
    );
  }
}
