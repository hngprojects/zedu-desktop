import 'package:zedu/features/features.dart';

class OrganizationPlanDetailsModel extends PlanDetails {
  const OrganizationPlanDetailsModel({
    required super.id,
    required super.name,
    required super.description,
    required super.benefits,
    required super.fee,
    required super.credits,
    required super.createdAt,
    required super.updatedAt,
  });

  factory OrganizationPlanDetailsModel.fromJson(Map<String, dynamic> json) {
    return OrganizationPlanDetailsModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      benefits: List<String>.from(json['benefits'] as List),
      fee: json['fee'] as num,
      credits: json['credits'] as num,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'benefits': benefits,
      'fee': fee,
      'credits': credits,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
