import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care_app/utils/app_colors.dart';
import 'package:pet_care_app/utils/app_images.dart';
import 'package:pet_care_app/view/dashboard_screen.dart';
import 'package:pet_care_app/view/forgot_password.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  obscureText: true,
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
                      border: const OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.only(right: 20.w),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForgotPassword(),
                          ));
                    },
                    child: Text("Forgot Password?",
                        style: GoogleFonts.fredoka(
                          textStyle: const TextStyle(color: Color.fromRGBO(0, 0, 0, 1), fontSize: 20, fontWeight: FontWeight.w400),
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 25.w, right: 25.w),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const DashboardScreen()));
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(245, 146, 69, 1), minimumSize: const Size(double.infinity, 50)),
                    child: Text("Login",
                        style: GoogleFonts.fredoka(
                          textStyle: const TextStyle(color: Color.fromRGBO(255, 255, 255, 1), fontSize: 25, fontWeight: FontWeight.w500),
                        ))),
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
              Padding(
                padding: EdgeInsets.only(left: 25.w, right: 25.w, bottom: 20.h),
                child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: CircleAvatar(
                      radius: 10.r,
                      backgroundColor: AppColors.orangeButton,
                      backgroundImage: AssetImage(AppImages.googleLogoImg),
                    ),
                    style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(245, 146, 69, 1), minimumSize: const Size(double.infinity, 50)),
                    label: Text("Login With Google",
                        style: GoogleFonts.fredoka(
                          textStyle: const TextStyle(color: Color.fromRGBO(255, 255, 255, 1), fontSize: 20, fontWeight: FontWeight.w400),
                        ))),
              ),
              // Padding(
              //   padding: EdgeInsets.only(left: 25.w, right: 25.w, bottom: 20.h),
              //   child: ElevatedButton.icon(
              //       onPressed: () {},
              //       icon: const Icon(Icons.facebook),
              //       style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(245, 146, 69, 1), minimumSize: const Size(double.infinity, 50)),
              //       label: Text("Login With Facebook",
              //           style: GoogleFonts.fredoka(
              //             textStyle: const TextStyle(color: Color.fromRGBO(255, 255, 255, 1), fontSize: 20, fontWeight: FontWeight.w400),
              //           ))),
              // ),
              // Padding(
              //   padding: EdgeInsets.only(left: 25.w, right: 25.w, bottom: 25.h),
              //   child: ElevatedButton.icon(
              //       onPressed: () {},
              //       icon: const Icon(
              //         Icons.apple,
              //       ),
              //       style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(245, 146, 69, 1), minimumSize: const Size(double.infinity, 50)),
              //       label: Text("Login With Apple",
              //           style: GoogleFonts.fredoka(
              //             textStyle: const TextStyle(color: Color.fromRGBO(255, 255, 255, 1), fontSize: 20, fontWeight: FontWeight.w400),
              //           ))),
              // ),
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
          )
        ],
      ),
    );
  }
}
