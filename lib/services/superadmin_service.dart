import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nephro_pancartes/models/superadmin.dart';

class SuperAdminService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add a SuperAdmin to Firestore
  Future<void> addSuperAdmin(SuperAdmin superAdmin) async {
    await _firestore
        .collection('superadmins')
        .doc(superAdmin.id)
        .set(superAdmin.toMap());
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
    await _firestore
        .collection('superadmins')
        .doc(superAdmin.id)
        .update(superAdmin.toMap());
  }

  // Delete a SuperAdmin from Firestore
  Future<void> deleteSuperAdmin(String id) async {
    await _firestore.collection('superadmins').doc(id).delete();
  }

  // Get a list of all SuperAdmins from Firestore
  Future<List<SuperAdmin>> getAllSuperAdmins() async {
    final querySnapshot = await _firestore.collection('superadmins').get();
    return querySnapshot.docs
        .map((doc) => SuperAdmin.fromDocumentSnapshot(doc))
        .toList();
  }
}
