// import 'dart:convert';

class UserProfile {
  final String id;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String accountStatus;
  final String role;
  // final String wallet_id;  later

  UserProfile({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.accountStatus,
    required this.role,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as String,
      fullName: json['full_name'] as String,
      email: json['email'] as String,
      phoneNumber: json['phone_number'] as String,
      accountStatus: json['account_status'] as String,
      role: json['role'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': fullName,
      'email': email,
      'phone_number': phoneNumber,
      'role': role,
      'account_status': accountStatus,
    };
  }
}
