import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nephro_pancartes/models/user.dart';
import 'package:nephro_pancartes/providers/auth_provider.dart';
import 'package:nephro_pancartes/providers/user_provider.dart';
import 'package:nephro_pancartes/widgets/custom_button.dart';

class SuperAdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('SuperAdmin Dashboard'),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, SuperAdmin!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            CustomButton(
              text: 'Manage Admins',
              onPressed: () {
                Navigator.of(context).pushNamed('/manage_admins');
              },
            ),
            SizedBox(height: 10),
            CustomButton(
              text: 'Manage Doctors',
              onPressed: () {
                Navigator.of(context).pushNamed('/manage_doctors');
              },
            ),
            SizedBox(height: 10),
            CustomButton(
              text: 'Manage Patients',
              onPressed: () {
                Navigator.of(context).pushNamed('/manage_patients');
              },
            ),
            SizedBox(height: 10),
            CustomButton(
              text: 'View System Data',
              onPressed: () {
                Navigator.of(context).pushNamed('/view_system_data');
              },
            ),
            SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<UserModel>>(
                future: userProvider.fetchAllUsers(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No users found.'));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final user = snapshot.data![index];
                        return ListTile(
                          title: Text(user.name),
                          subtitle: Text(user.email),
                          trailing: Text(user.role),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              '/edit_user',
                              arguments: user,
                            );
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
