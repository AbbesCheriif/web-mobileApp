import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nephro_pancartes/models/user.dart';
import 'package:nephro_pancartes/services/auth_service.dart';
import 'package:nephro_pancartes/services/user_service.dart';

class UserProvider with ChangeNotifier {
  UserModel? _currentUser;
  final AuthService _authService = AuthService();
  final UserService _userService = UserService();
  bool _isLoading = false;

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;

  // Initialize UserProvider and check if user is already logged in
  UserProvider() {
    _checkCurrentUser();
  }

  Future<void> _checkCurrentUser() async {
    final User? user = _authService.getCurrentUser();
    if (user != null) {
      _currentUser = await _userService.getUserById(user.uid);
    }
    notifyListeners();
  }

  // Sign In
  Future<bool> signIn(String email, String password) async {
    _setLoading(true);
    try {
      User? user = await _authService.signIn(email, password);
      if (user != null) {
        _currentUser = await _userService.getUserById(user.uid);
        _setLoading(false);
        notifyListeners();
        return true;
      }
    } catch (e) {
      print(e);
    }
    _setLoading(false);
    return false;
  }

  // Sign Up
  Future<bool> signUp(String email, String password, UserModel newUser) async {
    _setLoading(true);
    try {
      User? user = await _authService.signUp(email, password);
      if (user != null) {
        newUser.id = user.uid;
        await _userService.addUser(newUser);
        _currentUser = newUser;
        _setLoading(false);
        notifyListeners();
        return true;
      }
    } catch (e) {
      print(e);
    }
    _setLoading(false);
    return false;
  }

  // Sign Out
  Future<void> signOut() async {
    await _authService.signOut();
    _currentUser = null;
    notifyListeners();
  }

  // Update User
  Future<void> updateUser(UserModel updatedUser) async {
    _setLoading(true);
    try {
      await _userService.updateUser(updatedUser);
      _currentUser = updatedUser;
      notifyListeners();
    } catch (e) {
      print(e);
    }
    _setLoading(false);
  }

  // Set Loading
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
