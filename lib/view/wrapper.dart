import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_care_app/utils/user_data.dart';
import 'package:pet_care_app/view/admin_dashboard_screen.dart';
import 'package:pet_care_app/view/start_screen.dart';
import 'package:pet_care_app/view/user_views/dashboard_screen.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final UserData userData = UserData();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (userData.read("adminEnabled") == true) {
              return const AdminDashboardScreen();
            } else {
              return const DashboardScreen();
            }
          } else {
            return const StartScreen();
          }
        },
      ),
    );
  }
}
