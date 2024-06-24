import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nephro_pancartes/providers/auth_provider.dart';
import 'package:nephro_pancartes/widgets/role_based_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              authProvider.logout();
              Navigator.of(context).pushReplacementNamed('/login');
            },
          ),
        ],
      ),
      body: RoleBasedWidget(
        superadminWidget: Center(child: Text('Welcome Superadmin!')),
        adminWidget: Center(child: Text('Welcome Admin!')),
        doctorWidget: Center(child: Text('Welcome Doctor!')),
        patientWidget: Center(child: Text('Welcome Patient!')),
        defaultWidget: Center(child: Text('Welcome User!')),
      ),
    );
  }
}
