import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nephro_pancartes/models/patient.dart';

class PatientService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add a Patient to Firestore
  Future<void> addPatient(Patient patient) async {
    await _firestore
        .collection('patients')
        .doc(patient.id)
        .set(patient.toMap());
  }

  // Get a Patient from Firestore
  Future<Patient?> getPatient(String id) async {
    final doc = await _firestore.collection('patients').doc(id).get();
    if (doc.exists) {
      return Patient.fromDocumentSnapshot(doc);
    }
    return null;
  }

  // Update a Patient in Firestore
  Future<void> updatePatient(Patient patient) async {
    await _firestore
        .collection('patients')
        .doc(patient.id)
        .update(patient.toMap());
  }

  // Delete a Patient from Firestore
  Future<void> deletePatient(String id) async {
    await _firestore.collection('patients').doc(id).delete();
  }

  // Get a list of all Patients from Firestore
  Future<List<Patient>> getAllPatients() async {
    final querySnapshot = await _firestore.collection('patients').get();
    return querySnapshot.docs
        .map((doc) => Patient.fromDocumentSnapshot(doc))
        .toList();
  }

  // Get a list of Patients for a specific doctor from Firestore
  Future<List<Patient>> getPatientsByDoctorId(String doctorId) async {
    final querySnapshot = await _firestore
        .collection('patients')
        .where('doctorId', isEqualTo: doctorId)
        .get();
    return querySnapshot.docs
        .map((doc) => Patient.fromDocumentSnapshot(doc))
        .toList();
  }
}
