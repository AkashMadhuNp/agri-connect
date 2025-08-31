import 'package:firebase_auth/firebase_auth.dart';

class AuthResult {
  final bool success;
  final String message;
  final User? user;
  final String? error;

  AuthResult({
    required this.success,
    required this.message,
    this.user,
    this.error,
  });
}

class UserData {
  final String uid;
  final String name;
  final String email;
  final String phone;
  final String location;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserData({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.location,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
      'location': location,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      location: map['location'] ?? '',
      createdAt: DateTime.parse(map['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(map['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }
}