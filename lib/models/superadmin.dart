import 'package:cloud_firestore/cloud_firestore.dart';

class SuperAdmin {
  final String id;
  final String displayName;
  final String email;
  final String phoneNumber;

  SuperAdmin({
    required this.id,
    required this.displayName,
    required this.email,
    required this.phoneNumber,
  });

  // Convert a SuperAdmin object into a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'displayName': displayName,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }

  // Create a SuperAdmin object from a map
  factory SuperAdmin.fromMap(Map<String, dynamic> map, String documentId) {
    return SuperAdmin(
      id: documentId,
      displayName: map['displayName'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
    );
  }

  // Convert a Firestore document snapshot to a SuperAdmin object
  factory SuperAdmin.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return SuperAdmin.fromMap(data, doc.id);
  }
}
