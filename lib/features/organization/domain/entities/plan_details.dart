class PlanDetails {
  const PlanDetails({
    required this.id,
    required this.name,
    required this.description,
    required this.benefits,
    required this.fee,
    required this.credits,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String name;
  final String description;
  final List<String> benefits;
  final num fee;
  final num credits;
  final DateTime createdAt;
  final DateTime updatedAt;
}
