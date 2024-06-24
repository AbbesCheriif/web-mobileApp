import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nephro_pancartes/models/user.dart';
import 'package:nephro_pancartes/providers/auth_provider.dart';
import 'package:nephro_pancartes/providers/patient_provider.dart';
import 'package:nephro_pancartes/widgets/custom_button.dart';

class PatientDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final patientProvider = Provider.of<PatientProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Dashboard'),
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
              'Welcome, ${authProvider.user?.name ?? 'Patient'}!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            CustomButton(
              text: 'View Medical Records',
              onPressed: () {
                Navigator.of(context).pushNamed('/medical_records');
              },
            ),
            SizedBox(height: 10),
            CustomButton(
              text: 'View Appointments',
              onPressed: () {
                Navigator.of(context).pushNamed('/appointments');
              },
            ),
            SizedBox(height: 10),
            CustomButton(
              text: 'Update Personal Information',
              onPressed: () {
                Navigator.of(context).pushNamed('/update_info');
              },
            ),
            SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<UserModel>(
                future: patientProvider.fetchPatientDetails(authProvider.user!.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData) {
                    return Center(child: Text('No details found.'));
                  } else {
                    final patient = snapshot.data!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name: ${patient.name}',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          'Email: ${patient.email}',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          'Phone: ${patient.phone}',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
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
