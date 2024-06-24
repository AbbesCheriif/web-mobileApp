import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nephro_pancartes/services/auth_service.dart';
import 'package:nephro_pancartes/models/user.dart' as AppUser;
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _firebaseUser;
  AppUser.User? _appUser;

  User? get firebaseUser => _firebaseUser;
  AppUser.User? get appUser => _appUser;

  AuthProvider() {
    // Listen to authentication state changes
    _authService.user.listen(_onAuthStateChanged);
  }

  Future<void> _onAuthStateChanged(User? firebaseUser) async {
    _firebaseUser = firebaseUser;
    if (_firebaseUser != null) {
      // Fetch the user data from Firestore
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(_firebaseUser!.uid)
          .get();
      _appUser = AppUser.User.fromDocument(doc);
    } else {
      _appUser = null;
    }
    notifyListeners();
  }

  Future<void> signIn(String email, String password) async {
    _firebaseUser =
        await _authService.signInWithEmailAndPassword(email, password);
    if (_firebaseUser != null) {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(_firebaseUser!.uid)
          .get();
      _appUser = AppUser.User.fromDocument(doc);
    }
    notifyListeners();
  }

  Future<void> register(String email, String password, String displayName,
      String phoneNumber, AppUser.UserRole role) async {
    _firebaseUser =
        await _authService.registerWithEmailAndPassword(email, password);
    if (_firebaseUser != null) {
      // Create a new user in Firestore
      _appUser = AppUser.User(
        uid: _firebaseUser!.uid,
        email: email,
        displayName: displayName,
        phoneNumber: phoneNumber,
        role: role,
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_firebaseUser!.uid)
          .set(_appUser!.toMap());
    }
    notifyListeners();
  }

  Future<void> signOut() async {
    await _authService.signOut();
    _firebaseUser = null;
    _appUser = null;
    notifyListeners();
  }
}
