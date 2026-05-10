class UserRoleModel {
  const UserRoleModel({required this.roleId, required this.roleName});

  final String roleId;
  final String roleName;

  factory UserRoleModel.fromJson(Map<String, dynamic> json) {
    return UserRoleModel(
      roleId: json['role_id'] as String? ?? '',
      roleName: json['role_name'] as String? ?? '',
    );
  }
}
