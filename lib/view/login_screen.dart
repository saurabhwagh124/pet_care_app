import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care_app/controller/user_controller.dart';
import 'package:pet_care_app/utils/app_colors.dart';
import 'package:pet_care_app/utils/app_images.dart';
import 'package:pet_care_app/utils/auth_service.dart';
import 'package:pet_care_app/utils/user_data.dart';
import 'package:pet_care_app/view/admin_dashboard_screen.dart';
import 'package:pet_care_app/view/signup_screen.dart';
import 'package:pet_care_app/view/user_views/dashboard_screen.dart';
import 'package:pet_care_app/view/user_views/forgot_password_screen.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final UserData _userData = UserData();
  final _auth = AuthService();
  final userController = UserController();
  ValueNotifier<bool> isVisible = ValueNotifier(false);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
          Column(
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
              SizedBox(
                height: 45.h,
                width: 300.w,
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      labelText: "Email Address",
                      labelStyle: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromRGBO(166, 166, 166, 1),
                      ),
                      prefixIcon: const Icon(Icons.email_rounded),
                      prefixIconColor: const Color.fromRGBO(166, 166, 166, 1),
                      filled: true,
                      fillColor: const Color.fromRGBO(212, 212, 212, 1),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
              ),
              SizedBox(
                height: 45.h,
                width: 300.w,
                child: ValueListenableBuilder(
                  valueListenable: isVisible,
                  builder: (context, value, _) => TextFormField(
                    controller: _passwordController,
                    obscureText: !value,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromRGBO(166, 166, 166, 1),
                        ),
                        prefixIcon: const Icon(Icons.lock_outlined),
                        prefixIconColor: const Color.fromRGBO(166, 166, 166, 1),
                        filled: true,
                        fillColor: const Color.fromRGBO(212, 212, 212, 1),
                        suffixIcon: IconButton(
                          icon: Icon((value)
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined),
                          onPressed: () {
                            isVisible.value = !isVisible.value;
                          },
                        ),
                        suffixIconColor: const Color.fromRGBO(166, 166, 166, 1),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20.w),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => const ForgotPasswordScreen());
                    },
                    child: Text("Forgot Password?",
                        style: GoogleFonts.fredoka(
                          textStyle: const TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                        )),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "New here?   ",
                    style: GoogleFonts.fredoka(
                        textStyle: const TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontSize: 18,
                            fontWeight: FontWeight.w400)),
                  ),
                  InkWell(
                      onTap: () {
                        Get.to(() => const SignupScreen());
                      },
                      child: Text(
                        "Register",
                        style: GoogleFonts.fredoka(
                          textStyle: const TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontSize: 22,
                              fontWeight: FontWeight.w500),
                        ),
                      ))
                ],
              ),
              GestureDetector(
                onTap: _loginWithEmail,
                child: Container(
                  height: 40.h,
                  width: 300.w,
                  decoration: BoxDecoration(
                      color: AppColors.orangeButton,
                      borderRadius: BorderRadius.circular(10.r)),
                  margin: EdgeInsets.only(left: 25.w, right: 25.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(
                            color: AppColors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
              ),
              Text("Or connect with",
                  style: GoogleFonts.fredoka(
                    textStyle: const TextStyle(
                        color: Color.fromRGBO(116, 112, 112, 1),
                        fontSize: 25,
                        fontWeight: FontWeight.w400),
                  )),
              GestureDetector(
                onTap: _signInWithGoogle,
                child: Container(
                  height: 40.h,
                  width: 300.w,
                  decoration: BoxDecoration(
                      color: AppColors.orangeButton,
                      borderRadius: BorderRadius.circular(10.r)),
                  margin:
                      EdgeInsets.only(left: 25.w, right: 25.w, bottom: 20.h),
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
                        style: TextStyle(
                            color: AppColors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: _signInWithGoogleAdmin,
                // onTap: () => Get.to(const AdminDashboardScreen()),
                child: Container(
                  height: 40.h,
                  width: 300.w,
                  decoration: BoxDecoration(
                      color: AppColors.orangeButton,
                      borderRadius: BorderRadius.circular(10.r)),
                  margin:
                      EdgeInsets.only(left: 25.w, right: 25.w, bottom: 20.h),
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
                        "Admin Login with Google",
                        style: TextStyle(
                            color: AppColors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
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
                          textStyle: const TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontSize: 9,
                              fontWeight: FontWeight.w400),
                        )),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  _loginWithEmail() async {
    final user = await _auth.loginUserWithMailAndPassword(
        _emailController.text, _passwordController.text);
    if (user != null) {
      userController.fetchUserData(user.email ?? "");
      log("user logged in with email");
      Get.off(() => const DashboardScreen());
    } else {
      log("Login with email unsuccessfull");
      _emailController.clear();
      _passwordController.clear();
      // ScaffoldMessenger.of(context).showSnackBar()
    }
  }

  _signInWithGoogle() async {
    final userCred = await _auth.loginWithGoogle();
    if (userCred != null) {
      await userController.fetchUserData(userCred.user?.email ?? "");
      Get.off(() => const DashboardScreen());
      log("Gooogle login success");
    } else {
      log("Google login failed");
    }
  }

  _signInWithGoogleAdmin() async {
    final userCred = await _auth.loginWithGoogle();
    if (userCred != null) {
      userController.fetchUserData(userCred.user?.email ?? "");
      await Future.delayed(const Duration(seconds: 1));
      log(_userData.read("admin").toString());
      if (_userData.read("admin")) {
        Get.off(() => const AdminDashboardScreen());
      } else {
        _auth.signOut();
        Get.offAll(() => const Loginscreen());
        Get.snackbar("Error", "Not an admin", backgroundColor: Colors.red);
      }
      log("Gooogle login success");
    } else {
      log("Google login failed");
    }
  }
}
