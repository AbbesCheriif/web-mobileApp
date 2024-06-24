import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nephro_pancartes/models/user.dart';
import 'package:nephro_pancartes/providers/user_provider.dart';

class RoleBasedWidget extends StatelessWidget {
  final Widget superadminWidget;
  final Widget adminWidget;
  final Widget doctorWidget;
  final Widget patientWidget;
  final Widget defaultWidget;

  RoleBasedWidget({
    required this.superadminWidget,
    required this.adminWidget,
    required this.doctorWidget,
    required this.patientWidget,
    this.defaultWidget = const SizedBox.shrink(),
  });

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final UserModel? user = userProvider.currentUser;

    if (user == null) {
      return defaultWidget;
    }

    switch (user.role) {
      case 'superadmin':
        return superadminWidget;
      case 'admin':
        return adminWidget;
      case 'doctor':
        return doctorWidget;
      case 'patient':
        return patientWidget;
      default:
        return defaultWidget;
    }
  }
}
