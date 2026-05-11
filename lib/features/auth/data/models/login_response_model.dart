import 'package:zedu/features/features.dart';

class LoginResponseModel {
  const LoginResponseModel({
    required this.user,
    required this.accessToken,
    required this.accessTokenExpiresIn,
    required this.notificationToken,
  });

  final UserModel user;
  final String accessToken;
  final DateTime accessTokenExpiresIn;
  final String notificationToken;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      accessToken: json['access_token'] as String,
      accessTokenExpiresIn: DateTime.fromMillisecondsSinceEpoch(
        int.parse(json['access_token_expires_in'] as String) * 1000,
      ),
      notificationToken: json['notification_token'] as String,
    );
  }

  static const Map<String, dynamic> _mockLoginResponse = {
    "access_token":
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhY2Nlc3NfdXVpZCI6IjAxOWUxMDFiLTYzZmItN2Y5Zi04MTBlLWE1NjAzMjllYTRhNCIsImF1dGhvcmlzZWQiOnRydWUsImV4cCI6MTc3ODk5MTQ5MSwib3JnX2lkIjoiMDE5ZTBmNTYtNmJhYi03ZjlmLWE3ZmMtZDExOWU1ZGI1ODhiIiwicm9sZV9pZCI6bnVsbCwidXNlcl9pZCI6IjAxOWUwZjU2LTZiMDYtN2Y5ZS1hZDlkLTgyMDExYmNiNWUxYiJ9.OoNXSt9Xts5S4bZjYUJRC5-haCZBydq5Ws99YkbDTJ0",
    "access_token_expires_in": "1778991491",
    "notification_token": "IAK0C6kd9KBCyuky8RbN0Fh2pONDgzjK",
    "user": {
      "avatar_url": "",
      "created_at": "1778373782",
      "current_org": "019e0f56-6bab-7f9f-a7fc-d119e5db588b",
      "current_organisation_slug": "aloaderemi",
      "default_avatar_url":
          "https://media.zedu.chat/telexstagingbucket/public/default_avatars/default_avatar_13.png",
      "email": "aloaderemi@gmail+2.com",
      "expires_in": "1778991491",
      "first_name": "aloaderemi",
      "fullname": "aloaderemi ",
      "id": "019e0f56-6b06-7f9e-ad9d-82011bcb5e1b",
      "is_active": true,
      "is_onboarded": true,
      "is_verified": false,
      "last_name": "",
      "online": true,
      "organisation": {
        "id": "019e0f56-6bab-7f9f-a7fc-d119e5db588b",
        "name": "aloaderemi",
        "description": "aloaderemi's organization",
        "email": "aloaderemi@gmail+2.com",
        "type": "user default org",
        "location": "49.2497,-123.1193",
        "country": "ca",
        "owner_id": "019e0f56-6b06-7f9e-ad9d-82011bcb5e1b",
        "logo_url": "",
        "credit_balance": 10,
        "channels_count": 1,
        "total_messages_count": 0,
        "org_roles": [],
        "pinned": false,
        "Users": null,
        "created_at": "2026-05-10T02:43:02.443874+02:00",
        "updated_at": "2026-05-10T02:43:02.443874+02:00",
        "channels": null,
        "subscription_plan_id": "free",
        "stripe_customer_id": "",
        "org_plan_id": "019c3e25-7eec-70e9-b269-9cc98eb01e84",
        "organisation_plan": {
          "started_at": "0001-01-01T00:00:00Z",
          "ended_at": "0001-01-01T00:00:00Z",
          "created_at": "0001-01-01T00:00:00Z",
          "updated_at": "0001-01-01T00:00:00Z",
          "plan_details": {
            "id": "",
            "name": "",
            "description": "",
            "benefits": null,
            "fee": 0,
            "max_channels": 0,
            "max_users": 0,
            "max_notifications": 0,
            "can_upgrade_notifications": false,
            "can_add_unlimited_channels": false,
            "can_add_unlimited_users": false,
            "is_for_individuals": false,
            "is_for_small_business": false,
            "is_for_large_enterprise": false,
            "unlimited_ai_co_workers": false,
            "create_your_own_ai_co_workers": false,
            "ai_credits_purchasable": false,
            "max_call_duration": 0,
            "max_buzz_participants": 0,
            "max_active_calls": 0,
            "call_records_available": false,
            "transcript_available": false,
            "advanced_controls": false,
            "advanced_controls_user": false,
            "created_at": "0001-01-01T00:00:00Z",
            "credits": 0,
            "updated_at": "0001-01-01T00:00:00Z",
          },
        },
        "organisation_slug": "",
        "user_role": {"role_id": "", "role_name": ""},
      },
      "phone": "",
      "profile_updated": true,
      "updated_at": "1778386691",
      "user_id": "019e0f56-6b06-7f9e-ad9d-82011bcb5e1b",
      "username": "aloaderemi",
    },
  };

  static Map<String, dynamic> get mockLoginResponse => _mockLoginResponse;
}
