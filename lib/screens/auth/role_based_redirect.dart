import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nephro_pancartes/providers/auth_provider.dart';
import 'package:nephro_pancartes/screens/admin/admin_dashboard.dart';
import 'package:nephro_pancartes/screens/superadmin/superadmin_dashboard.dart';
import 'package:nephro_pancartes/screens/doctor/doctor_dashboard.dart';
import 'package:nephro_pancartes/screens/patient/patient_dashboard.dart';
import 'package:nephro_pancartes/models/user.dart' as AppUser;
import 'package:nephro_pancartes/screens/auth/login_screen.dart';

class RoleBasedRedirect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final appUser = authProvider.appUser;

    if (authProvider.firebaseUser == null) {
      return LoginScreen();
    } else {
      switch (appUser?.role) {
        case AppUser.UserRole.Superadmin:
          return SuperAdminDashboard();
        case AppUser.UserRole.Admin:
          return AdminDashboard();
        case AppUser.UserRole.Doctor:
          return DoctorDashboard();
        case AppUser.UserRole.Patient:
          return PatientDashboard();
        default:
          return LoginScreen(); // fallback in case of unknown role
      }
    }
  }
}
