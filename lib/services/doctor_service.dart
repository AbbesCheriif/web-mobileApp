import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nephro_pancartes/models/doctor.dart';

class DoctorService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add a Doctor to Firestore
  Future<void> addDoctor(Doctor doctor) async {
    await _firestore.collection('doctors').doc(doctor.id).set(doctor.toMap());
  }

  // Get a Doctor from Firestore
  Future<Doctor?> getDoctor(String id) async {
    final doc = await _firestore.collection('doctors').doc(id).get();
    if (doc.exists) {
      return Doctor.fromDocumentSnapshot(doc);
    }
    return null;
  }

  // Update a Doctor in Firestore
  Future<void> updateDoctor(Doctor doctor) async {
    await _firestore
        .collection('doctors')
        .doc(doctor.id)
        .update(doctor.toMap());
  }

  // Delete a Doctor from Firestore
  Future<void> deleteDoctor(String id) async {
    await _firestore.collection('doctors').doc(id).delete();
  }

  // Get a list of all Doctors from Firestore
  Future<List<Doctor>> getAllDoctors() async {
    final querySnapshot = await _firestore.collection('doctors').get();
    return querySnapshot.docs
        .map((doc) => Doctor.fromDocumentSnapshot(doc))
        .toList();
  }

  // Get a list of Doctors for a specific department from Firestore
  Future<List<Doctor>> getDoctorsByDepartment(String department) async {
    final querySnapshot = await _firestore
        .collection('doctors')
        .where('department', isEqualTo: department)
        .get();
    return querySnapshot.docs
        .map((doc) => Doctor.fromDocumentSnapshot(doc))
        .toList();
  }
}
