import 'package:cloud_firestore/cloud_firestore.dart';

class UserMdl {
  String name;
  String phone;
  String email;
  String address;
  String gender;
  String fcm;
  String createdAt;

  UserMdl({
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.gender,
    required this.fcm,
    String? createdAt,
  }) : createdAt =
           createdAt ?? Timestamp.now().toDate().toUtc().toIso8601String();

  factory UserMdl.fromJson(Map<String, dynamic> json) {
    return UserMdl(
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      address: json['address'] ?? '',
      gender: json['gender'] ?? '',
      fcm: json['fcm'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'address': address,
      'gender': gender,
      "fcm": fcm,
      'createdAt': createdAt,
    };
  }
}
