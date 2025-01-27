import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care_app/utils/app_colors.dart';
import 'package:pet_care_app/utils/app_images.dart';
import 'package:pet_care_app/utils/app_validator.dart';
import 'package:pet_care_app/utils/auth_service.dart';
import 'package:pet_care_app/view/dashboard_screen.dart';
import 'package:pet_care_app/view/email_verification_screen.dart';
import 'package:pet_care_app/view/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _auth = AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SizedBox(
            width: double.maxFinite,
            height: double.maxFinite,
            child: Image.asset(
              AppImages.logoBgImg,
              fit: BoxFit.fitWidth,
            ),
          ),
          Positioned(
            top: -270.h,
            left: 130.w,
            child: CircleAvatar(
              radius: 185.r,
              backgroundColor: AppColors.yellowCircle,
            ),
          ),
          Positioned(
            top: -200.h,
            left: 270.w,
            child: CircleAvatar(
              radius: 185.r,
              backgroundColor: AppColors.orangeButton,
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: double.maxFinite,
                ),
                Container(
                  height: 200.h,
                  margin: EdgeInsets.only(top: 20.h),
                  child: Image.asset(AppImages.logoImg),
                ),
                Text(
                  "Sign up",
                  style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500, color: AppColors.greyTextColor),
                ),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                  height: 45.h,
                  width: 300.w,
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _emailController,
                    validator: AppValidators.validateEmail,
                    decoration: InputDecoration(
                        labelText: "Email Address",
                        labelStyle: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        prefixIcon: const Icon(Icons.email_rounded),
                        prefixIconColor: const Color.fromRGBO(166, 166, 166, 1),
                        filled: true,
                        fillColor: const Color.fromARGB(161, 212, 212, 212),
                        border: const OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(10)))),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  height: 45.h,
                  width: 300.w,
                  child: TextFormField(
                    controller: _passwordController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: AppValidators.validatePassword,
                    obscureText: true,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        prefixIcon: const Icon(Icons.lock_outlined),
                        prefixIconColor: const Color.fromRGBO(166, 166, 166, 1),
                        filled: true,
                        fillColor: const Color.fromARGB(161, 212, 212, 212),
                        border: const OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(10)))),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  height: 45.h,
                  width: 300.w,
                  child: TextFormField(
                    controller: _confirmPasswordController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => AppValidators.validateConfirmPassword(value, _passwordController.text),
                    obscureText: true,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        prefixIcon: const Icon(Icons.lock_outlined),
                        prefixIconColor: const Color.fromRGBO(166, 166, 166, 1),
                        filled: true,
                        fillColor: const Color.fromARGB(161, 212, 212, 212),
                        border: const OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(10)))),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState?.validate() == true) {
                      _signInWithEmail();
                    } else {
                      FlutterError('Password do not match');
                    }
                  },
                  child: Container(
                    height: 40.h,
                    width: 300.w,
                    decoration: BoxDecoration(color: AppColors.orangeButton, borderRadius: BorderRadius.circular(10.r)),
                    margin: EdgeInsets.only(left: 25.w, right: 25.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Signup",
                          style: TextStyle(color: AppColors.white, fontSize: 20.sp, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text("Or connect with",
                    style: GoogleFonts.fredoka(
                      textStyle: const TextStyle(color: Color.fromRGBO(116, 112, 112, 1), fontSize: 25, fontWeight: FontWeight.w400),
                    )),
                SizedBox(
                  height: 20.h,
                ),
                GestureDetector(
                  onTap: _signInWithGoogle,
                  child: Container(
                    height: 40.h,
                    width: 300.w,
                    decoration: BoxDecoration(color: AppColors.orangeButton, borderRadius: BorderRadius.circular(10.r)),
                    margin: EdgeInsets.only(left: 25.w, right: 25.w, bottom: 20.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 10.r,
                          backgroundColor: AppColors.orangeButton,
                          backgroundImage: AssetImage(AppImages.googleLogoImg),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          "Login with Google",
                          style: TextStyle(color: AppColors.white, fontSize: 16.sp, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(color: Color.fromRGBO(161, 161, 161, 1), fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    GestureDetector(
                      onTap: () {
                        log("Login tapped");
                        Get.to(() => const Loginscreen());
                      },
                      child: const Text(
                        "Login ",
                        style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1), fontSize: 15, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 25.h,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(248, 174, 31, 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.copyright,
                        color: Colors.white,
                        size: 12.48,
                      ),
                      Text(" All Rights Reserved",
                          style: GoogleFonts.fredoka(
                            textStyle: const TextStyle(color: Color.fromRGBO(255, 255, 255, 1), fontSize: 9, fontWeight: FontWeight.w400),
                          )),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _signInWithEmail() async {
    final user = await _auth.createUserWithMailAndPassword(_emailController.text.trim(), _passwordController.text.trim());
    if (user != null) {
      Get.off(() => const EmailVerificationScreen());
      log('Sign in with mail successfull');
    } else {
      log("Error");
      _emailController.clear();
      _passwordController.clear();
      _confirmPasswordController.clear();
    }
  }

  _signInWithGoogle() async {
    final userCred = await _auth.loginWithGoogle();
    if (userCred != null) {
      Get.off(() => const DashboardScreen());
      log("Gooogle login success");
    } else {
      log("Google login failed");
    }
  }
}
