import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nephro_pancartes/models/patient.dart';
import 'package:nephro_pancartes/providers/patient_provider.dart';
import 'package:nephro_pancartes/widgets/custom_button.dart';

class PatientRecordsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final patientProvider = Provider.of<PatientProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Records'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed('/add_patient');
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Patient>>(
        future: patientProvider.fetchPatients(),
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
                        '/patient_details',
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
    );
  }
}
