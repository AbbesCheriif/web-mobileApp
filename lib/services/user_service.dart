import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nephro_pancartes/models/superadmin.dart';
import 'package:nephro_pancartes/models/admin.dart';
import 'package:nephro_pancartes/models/doctor.dart';
import 'package:nephro_pancartes/models/patient.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add a SuperAdmin to Firestore
  Future<void> addSuperAdmin(SuperAdmin superAdmin) async {
    await _firestore.collection('superadmins').doc(superAdmin.id).set(superAdmin.toMap());
  }

  // Get a SuperAdmin from Firestore
  Future<SuperAdmin?> getSuperAdmin(String id) async {
    final doc = await _firestore.collection('superadmins').doc(id).get();
    if (doc.exists) {
      return SuperAdmin.fromDocumentSnapshot(doc);
    }
    return null;
  }

  // Update a SuperAdmin in Firestore
  Future<void> updateSuperAdmin(SuperAdmin superAdmin) async {
    await _firestore.collection('superadmins').doc(superAdmin.id).update(superAdmin.toMap());
  }

  // Delete a SuperAdmin from Firestore
  Future<void> deleteSuperAdmin(String id) async {
    await _firestore.collection('superadmins').doc(id).delete();
  }

  // Add an Admin to Firestore
  Future<void> addAdmin(Admin admin) async {
    await _firestore.collection('admins').doc(admin.id).set(admin.toMap());
  }

  // Get an Admin from Firestore
  Future<Admin?> getAdmin(String id) async {
    final doc = await _firestore.collection('admins').doc(id).get();
    if (doc.exists) {
      return Admin.fromDocumentSnapshot(doc);
    }
    return null;
  }

  // Update an Admin in Firestore
  Future<void> updateAdmin(Admin admin) async {
    await _firestore.collection('admins').doc(admin.id).update(admin.toMap());
  }

  // Delete an Admin from Firestore
  Future<void> deleteAdmin(String id) async {
    await _firestore.collection('admins').doc(id).delete();
  }

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
    await _firestore.collection('doctors').doc(doctor.id).update(doctor.toMap());
  }

  // Delete a Doctor from Firestore
  Future<void> deleteDoctor(String id) async {
    await _firestore.collection('doctors').doc(id).delete();
  }

  // Add a Patient to Firestore
  Future<void> addPatient(Patient patient) async {
    await _firestore.collection('patients').doc(patient.id).set(patient.toMap());
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
    await _firestore.collection('patients').doc(patient.id).update(patient.toMap());
  }

  // Delete a Patient from Firestore
  Future<void> deletePatient(String id) async {
    await _firestore.collection('patients').doc(id).delete();
  }
}
