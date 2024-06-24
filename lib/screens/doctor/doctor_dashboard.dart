import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nephro_pancartes/models/user.dart';
import 'package:nephro_pancartes/providers/auth_provider.dart';
import 'package:nephro_pancartes/providers/user_provider.dart';
import 'package:nephro_pancartes/widgets/custom_button.dart';

class DoctorDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Dashboard'),
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
              'Welcome, Doctor!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            CustomButton(
              text: 'View Patients',
              onPressed: () {
                Navigator.of(context).pushNamed('/view_patients');
              },
            ),
            SizedBox(height: 10),
            CustomButton(
              text: 'Schedule Appointment',
              onPressed: () {
                Navigator.of(context).pushNamed('/schedule_appointment');
              },
            ),
            SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<UserModel>>(
                future:
                    userProvider.fetchPatientsByDoctor(authProvider.user!.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No patients found.'));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final patient = snapshot.data![index];
                        return ListTile(
                          title: Text(patient.name),
                          subtitle: Text(patient.email),
                          trailing: IconButton(
                            icon: Icon(Icons.arrow_forward),
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                '/view_patient',
                                arguments: patient,
                              );
                            },
                          ),
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
