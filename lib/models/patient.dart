import 'package:cloud_firestore/cloud_firestore.dart';

class Patient {
  final String id;
  final String displayName;
  final String email;
  final String phoneNumber;
  final DateTime birthDate;
  final String gender;
  final String address;
  final String medicalHistory;
  final List<String> allergies;
  final List<String> medications;
  final String doctorId;

  Patient({
    required this.id,
    required this.displayName,
    required this.email,
    required this.phoneNumber,
    required this.birthDate,
    required this.gender,
    required this.address,
    required this.medicalHistory,
    required this.allergies,
    required this.medications,
    required this.doctorId,
  });

  // Convert a Patient object into a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'displayName': displayName,
      'email': email,
      'phoneNumber': phoneNumber,
      'birthDate': birthDate.toIso8601String(),
      'gender': gender,
      'address': address,
      'medicalHistory': medicalHistory,
      'allergies': allergies,
      'medications': medications,
      'doctorId': doctorId,
    };
  }

  // Create a Patient object from a map
  factory Patient.fromMap(Map<String, dynamic> map, String documentId) {
    return Patient(
      id: documentId,
      displayName: map['displayName'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      birthDate: DateTime.parse(map['birthDate']),
      gender: map['gender'] ?? '',
      address: map['address'] ?? '',
      medicalHistory: map['medicalHistory'] ?? '',
      allergies: List<String>.from(map['allergies'] ?? []),
      medications: List<String>.from(map['medications'] ?? []),
      doctorId: map['doctorId'] ?? '',
    );
  }

  // Convert a Firestore document snapshot to a Patient object
  factory Patient.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Patient.fromMap(data, doc.id);
  }
}
