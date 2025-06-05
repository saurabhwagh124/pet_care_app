import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:pet_care_app/utils/app_colors.dart';
import 'package:pet_care_app/view/user_views/dashboard_screen.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final _auth = FirebaseAuth.instance;
  User? _user;
  Timer? _timer;
  bool isVerified = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    _user = _auth.currentUser;
    if (_user != null && !_user!.emailVerified) {
      sendVerificationEmail();
      startEmailVerificationCheck();
    } else {
      setState(() {
        isVerified = true;
      });
    }
    });
  }

  void sendVerificationEmail() async {
    try {
      await _user?.sendEmailVerification();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Verification email sent to ${_user?.email}.'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error sending verification email: $e'),
        ),
      );
    }
  }

  void startEmailVerificationCheck() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      await _user?.reload(); // Refresh the user state
      _user = _auth.currentUser;

      if (_user != null && _user!.emailVerified) {
        timer.cancel(); // Stop the timer
        setState(() {
          isVerified = true;
          Get.to(() => const DashboardScreen());
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.greenAccent,
            content: Text('Email verified successfully!🎉'),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the screen is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 25.sp),
          onPressed: () => Get.back(),
        ),
        backgroundColor: AppColors.yellowCircle,
        title: const Text('Email Verification'),
      ),
      body: Center(
        child: isVerified
            ? const Text(
                'Email Verified! 🎉',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Please verify your email address.',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'A verification email has been sent to ${_user?.email}.',
                  ),
                  SizedBox(height: 20.h),
                  ElevatedButton(
                    onPressed: sendVerificationEmail,
                    child: const Text('Resend Verification Email'),
                  ),
                ],
              ),
      ),
    );
  }
}
