import 'package:cloud_firestore/cloud_firestore.dart';

class Admin {
  final String id;
  final String displayName;
  final String email;
  final String phoneNumber;
  final String department;

  Admin({
    required this.id,
    required this.displayName,
    required this.email,
    required this.phoneNumber,
    required this.department,
  });

  // Convert an Admin object into a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'displayName': displayName,
      'email': email,
      'phoneNumber': phoneNumber,
      'department': department,
    };
  }

  // Create an Admin object from a map
  factory Admin.fromMap(Map<String, dynamic> map, String documentId) {
    return Admin(
      id: documentId,
      displayName: map['displayName'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      department: map['department'] ?? '',
    );
  }

  // Convert a Firestore document snapshot to an Admin object
  factory Admin.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Admin.fromMap(data, doc.id);
  }
}
