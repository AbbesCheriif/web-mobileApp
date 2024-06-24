import 'package:cloud_firestore/cloud_firestore.dart';

class Doctor {
  final String id;
  final String displayName;
  final String email;
  final String phoneNumber;
  final String specialization;
  final String address;
  final String bio;
  final List<String> patients; // List of patient IDs

  Doctor({
    required this.id,
    required this.displayName,
    required this.email,
    required this.phoneNumber,
    required this.specialization,
    required this.address,
    required this.bio,
    required this.patients,
  });

  // Convert a Doctor object into a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'displayName': displayName,
      'email': email,
      'phoneNumber': phoneNumber,
      'specialization': specialization,
      'address': address,
      'bio': bio,
      'patients': patients,
    };
  }

  // Create a Doctor object from a map
  factory Doctor.fromMap(Map<String, dynamic> map, String documentId) {
    return Doctor(
      id: documentId,
      displayName: map['displayName'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      specialization: map['specialization'] ?? '',
      address: map['address'] ?? '',
      bio: map['bio'] ?? '',
      patients: List<String>.from(map['patients'] ?? []),
    );
  }

  // Convert a Firestore document snapshot to a Doctor object
  factory Doctor.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Doctor.fromMap(data, doc.id);
  }
}
