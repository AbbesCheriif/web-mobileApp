import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:nephro_pancartes/providers/auth_provider.dart';
import 'package:nephro_pancartes/screens/auth/login_screen.dart';
import 'package:nephro_pancartes/screens/auth/register_screen.dart';
import 'package:nephro_pancartes/screens/auth/role_based_redirect.dart';
import 'package:nephro_pancartes/screens/common/home_screen.dart';
import 'package:nephro_pancartes/screens/common/profile_screen.dart';
import 'package:nephro_pancartes/screens/superadmin/superadmin_dashboard.dart';
import 'package:nephro_pancartes/screens/superadmin/manage_users.dart';
import 'package:nephro_pancartes/screens/admin/admin_dashboard.dart';
import 'package:nephro_pancartes/screens/admin/manage_doctors.dart';
import 'package:nephro_pancartes/screens/admin/manage_patients.dart';
import 'package:nephro_pancartes/screens/doctor/doctor_dashboard.dart';
//import 'package:nephro_pancartes/screens/doctor/manage_appointments.dart';
import 'package:nephro_pancartes/screens/doctor/patient_records.dart';
import 'package:nephro_pancartes/screens/patient/patient_dashboard.dart';
import 'package:nephro_pancartes/screens/patient/medical_history.dart';
import 'package:nephro_pancartes/utils/theme.dart';
import 'app.dart';
import 'package:nephro_pancartes/utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        // Ajoutez ici d'autres providers si nécessaire
      ],
      child: MaterialApp(
        title: 'Nephro Service App',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        initialRoute: '/',
        routes: {
          '/': (context) => RoleBasedRedirect(),
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
          '/home': (context) => HomeScreen(),
          '/profile': (context) => ProfileScreen(),
          '/superadmin/dashboard': (context) => SuperAdminDashboard(),
          '/superadmin/manage-users': (context) => ManageUsersScreen(),
          '/admin/dashboard': (context) => AdminDashboard(),
          '/admin/manage-doctors': (context) => ManageDoctorsScreen(),
          '/admin/manage-patients': (context) => ManagePatientsScreen(),
          '/doctor/dashboard': (context) => DoctorDashboard(),
          //'/doctor/manage-appointments': (context) => ManageAppointmentsScreen(),
          '/doctor/patient-records': (context) => PatientRecordsScreen(),
          '/patient/dashboard': (context) => PatientDashboard(),
          '/patient/medical-history': (context) => MedicalHistoryScreen(),
        },
      ),
    );
  }
}
