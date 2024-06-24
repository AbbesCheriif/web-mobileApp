import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nephro_pancartes/models/medical_record.dart';
import 'package:nephro_pancartes/providers/medical_record_provider.dart';
import 'package:nephro_pancartes/providers/auth_provider.dart';

class MedicalHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final medicalRecordProvider = Provider.of<MedicalRecordProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Medical History'),
      ),
      body: FutureBuilder<List<MedicalRecord>>(
        future: medicalRecordProvider.fetchMedicalRecords(authProvider.user!.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No medical history found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final record = snapshot.data![index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text('Date: ${record.date}'),
                    subtitle: Text(record.description),
                    trailing: IconButton(
                      icon: Icon(Icons.info),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MedicalRecordDetailScreen(record: record),
                          ),
                        );
                      },
                    ),
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

class MedicalRecordDetailScreen extends StatelessWidget {
  final MedicalRecord record;

  MedicalRecordDetailScreen({required this.record});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medical Record Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Date: ${record.date}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Description:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(record.description),
            SizedBox(height: 10),
            Text(
              'Doctor: ${record.doctorName}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text('Notes:'),
            SizedBox(height: 5),
            Text(record.notes),
          ],
        ),
      ),
    );
  }
}
