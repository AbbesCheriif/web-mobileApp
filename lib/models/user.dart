import 'package:cloud_firestore/cloud_firestore.dart';

enum UserRole { SuperAdmin, Admin, Doctor, Patient }

class User {
  final String uid;
  final String email;
  final String displayName;
  final UserRole role;
  final String phoneNumber;

  User({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.role,
    required this.phoneNumber,
  });

  // Convert UserRole to String
  String get roleString => role.toString().split('.').last;

  // Convert String to UserRole
  static UserRole roleFromString(String roleString) {
    return UserRole.values.firstWhere((role) => role.toString().split('.').last == roleString);
  }

  // Factory constructor to create a User from a Firebase document
  factory User.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return User(
      uid: doc.id,
      email: data['email'],
      displayName: data['displayName'],
      role: roleFromString(data['role']),
      phoneNumber: data['phoneNumber'],
    );
  }

  // Convert User to a Map
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'role': roleString,
      'phoneNumber': phoneNumber,
    };
  }
}
