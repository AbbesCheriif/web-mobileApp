import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nephro_pancartes/models/admin.dart';

class AdminService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  // Get a list of all Admins from Firestore
  Future<List<Admin>> getAllAdmins() async {
    final querySnapshot = await _firestore.collection('admins').get();
    return querySnapshot.docs
        .map((doc) => Admin.fromDocumentSnapshot(doc))
        .toList();
  }

  // Get a list of Admins for a specific hospital from Firestore
  Future<List<Admin>> getAdminsByHospitalId(String hospitalId) async {
    final querySnapshot = await _firestore
        .collection('admins')
        .where('hospitalId', isEqualTo: hospitalId)
        .get();
    return querySnapshot.docs
        .map((doc) => Admin.fromDocumentSnapshot(doc))
        .toList();
  }
}
