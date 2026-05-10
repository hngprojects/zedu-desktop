class PlanDetailsModel {
  const PlanDetailsModel({
    required this.id,
    required this.name,
    required this.description,
    required this.benefits,
    required this.fee,
    required this.maxChannels,
    required this.maxUsers,
    required this.maxNotifications,
    required this.canUpgradeNotifications,
    required this.canAddUnlimitedChannels,
    required this.canAddUnlimitedUsers,
    required this.isForIndividuals,
    required this.isForSmallBusiness,
    required this.isForLargeEnterprise,
    required this.unlimitedAiCoWorkers,
    required this.createYourOwnAiCoWorkers,
    required this.aiCreditsPurchasable,
    required this.maxCallDuration,
    required this.maxBuzzParticipants,
    required this.maxActiveCalls,
    required this.callRecordsAvailable,
    required this.transcriptAvailable,
    required this.advancedControls,
    required this.advancedControlsUser,
    required this.createdAt,
    required this.credits,
    required this.updatedAt,
  });

  final String id;
  final String name;
  final String description;
  final List<String>? benefits;
  final int fee;
  final int maxChannels;
  final int maxUsers;
  final int maxNotifications;
  final bool canUpgradeNotifications;
  final bool canAddUnlimitedChannels;
  final bool canAddUnlimitedUsers;
  final bool isForIndividuals;
  final bool isForSmallBusiness;
  final bool isForLargeEnterprise;
  final bool unlimitedAiCoWorkers;
  final bool createYourOwnAiCoWorkers;
  final bool aiCreditsPurchasable;
  final int maxCallDuration;
  final int maxBuzzParticipants;
  final int maxActiveCalls;
  final bool callRecordsAvailable;
  final bool transcriptAvailable;
  final bool advancedControls;
  final bool advancedControlsUser;
  final DateTime createdAt;
  final int credits;
  final DateTime updatedAt;

  factory PlanDetailsModel.fromJson(Map<String, dynamic> json) {
    return PlanDetailsModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      benefits: (json['benefits'] as List<dynamic>?)?.cast<String>(),
      fee: json['fee'] as int? ?? 0,
      maxChannels: json['max_channels'] as int? ?? 0,
      maxUsers: json['max_users'] as int? ?? 0,
      maxNotifications: json['max_notifications'] as int? ?? 0,
      canUpgradeNotifications:
          json['can_upgrade_notifications'] as bool? ?? false,
      canAddUnlimitedChannels:
          json['can_add_unlimited_channels'] as bool? ?? false,
      canAddUnlimitedUsers: json['can_add_unlimited_users'] as bool? ?? false,
      isForIndividuals: json['is_for_individuals'] as bool? ?? false,
      isForSmallBusiness: json['is_for_small_business'] as bool? ?? false,
      isForLargeEnterprise: json['is_for_large_enterprise'] as bool? ?? false,
      unlimitedAiCoWorkers: json['unlimited_ai_co_workers'] as bool? ?? false,
      createYourOwnAiCoWorkers:
          json['create_your_own_ai_co_workers'] as bool? ?? false,
      aiCreditsPurchasable: json['ai_credits_purchasable'] as bool? ?? false,
      maxCallDuration: json['max_call_duration'] as int? ?? 0,
      maxBuzzParticipants: json['max_buzz_participants'] as int? ?? 0,
      maxActiveCalls: json['max_active_calls'] as int? ?? 0,
      callRecordsAvailable: json['call_records_available'] as bool? ?? false,
      transcriptAvailable: json['transcript_available'] as bool? ?? false,
      advancedControls: json['advanced_controls'] as bool? ?? false,
      advancedControlsUser: json['advanced_controls_user'] as bool? ?? false,
      createdAt: DateTime.parse(
        json['created_at'] as String? ?? '0001-01-01T00:00:00Z',
      ),
      credits: json['credits'] as int? ?? 0,
      updatedAt: DateTime.parse(
        json['updated_at'] as String? ?? '0001-01-01T00:00:00Z',
      ),
    );
  }
}
