import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pet_care_app/utils/app_colors.dart';
import 'package:pet_care_app/utils/app_images.dart';
import 'package:pet_care_app/view/login_screen.dart';
import 'package:pet_care_app/view/signup_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  int screen = 0;
  List<String> imageList = [
    AppImages.splash1Img,
    AppImages.splash2Img,
    AppImages.splash3Img
  ];
  List<String> buttonTextList = ['Next', 'Next', 'GetStarted'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.maxFinite,
            child: Image.asset(
              imageList[screen],
              fit: BoxFit.fill,
            ),
          ),
          Column(
            children: [
              const Expanded(
                child: SizedBox.shrink(),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.white90,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.r),
                          topRight: Radius.circular(30.r))),
                  padding: EdgeInsets.all(20.h),
                  child: (screen > 0)
                      ? (screen == 2)
                          ? screen3Elements(context)
                          : screen2Elements(context)
                      : screen1Elements(context),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget screen1Elements(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          width: double.maxFinite,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 7.h,
              width: 50.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.r),
                  color: (screen == 0) ? Colors.grey : AppColors.white90,
                  border: Border.all(color: Colors.grey)),
            ),
            Container(
              height: 7.h,
              width: 50.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.r),
                  color: (screen == 1) ? Colors.grey : AppColors.white90,
                  border: Border.all(color: Colors.grey)),
            ),
            Container(
              height: 7.h,
              width: 50.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.r),
                  color: (screen == 2) ? Colors.grey : AppColors.white90,
                  border: Border.all(color: Colors.grey)),
            )
          ],
        ),
        SizedBox(
          width: 160.w,
          child: Image.asset(AppImages.logoImg),
        ),
        Text(
          "Hello!!",
          style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w800),
        ),
        Column(
          children: [
            Text(
              "Sit back and relax we'll take care",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.lightGreyText,
                  fontSize: 16.sp),
            ),
            Text(
              "of your pet needs",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.lightGreyText,
                  fontSize: 16.sp),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            if (screen == 2) {
              setState(() {
                screen = 0;
              });
            } else {
              setState(() {
                screen += 1;
              });
            }
          },
          child: Container(
            height: 50.h,
            width: 350.w,
            decoration: BoxDecoration(
                color: AppColors.orangeButton,
                borderRadius: BorderRadius.circular(10.r)),
            child: Row(
              children: [
                const Spacer(),
                Text(
                  buttonTextList[screen],
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFFFFFFF)),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  weight: 100.sp,
                  size: 20.sp,
                  color: const Color(0xFFFFFFFF),
                ),
                SizedBox(
                  width: 10.w,
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget screen2Elements(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          width: double.maxFinite,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 7.h,
              width: 50.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.r),
                  color: (screen == 0) ? Colors.grey : AppColors.white90,
                  border: Border.all(color: Colors.grey)),
            ),
            Container(
              height: 7.h,
              width: 50.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.r),
                  color: (screen == 1) ? Colors.grey : AppColors.white90,
                  border: Border.all(color: Colors.grey)),
            ),
            Container(
              height: 7.h,
              width: 50.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.r),
                  color: (screen == 2) ? Colors.grey : AppColors.white90,
                  border: Border.all(color: Colors.grey)),
            )
          ],
        ),
        Text(
          "Now !",
          style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w800),
        ),
        Column(
          children: [
            Text(
              "One tap for foods, accessories, health ",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.lightGreyText,
                  fontSize: 16.sp),
            ),
            Text(
              "care products & digital gadgets",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.lightGreyText,
                  fontSize: 16.sp),
            ),
            Text(
              "Grooming & boarding",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.lightGreyText,
                  fontSize: 16.sp),
            ),
            Text(
              "Easy & best consultation bookings",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.lightGreyText,
                  fontSize: 16.sp),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            if (screen == 2) {
              setState(() {
                screen = 0;
              });
            } else {
              setState(() {
                screen += 1;
              });
            }
          },
          child: Container(
            height: 50.h,
            width: 350.w,
            decoration: BoxDecoration(
                color: AppColors.orangeButton,
                borderRadius: BorderRadius.circular(10.r)),
            child: Row(
              children: [
                const Spacer(),
                Text(
                  buttonTextList[screen],
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFFFFFFF)),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  weight: 100.sp,
                  size: 20.sp,
                  color: const Color(0xFFFFFFFF),
                ),
                SizedBox(
                  width: 10.w,
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget screen3Elements(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          width: double.maxFinite,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 7.h,
              width: 50.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.r),
                  color: (screen == 0) ? Colors.grey : AppColors.white90,
                  border: Border.all(color: Colors.grey)),
            ),
            Container(
              height: 7.h,
              width: 50.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.r),
                  color: (screen == 1) ? Colors.grey : AppColors.white90,
                  border: Border.all(color: Colors.grey)),
            ),
            Container(
              height: 7.h,
              width: 50.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.r),
                  color: (screen == 2) ? Colors.grey : AppColors.white90,
                  border: Border.all(color: Colors.grey)),
            )
          ],
        ),
        Text(
          "We Provide",
          style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w800),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "24hrs health tracking and health updates",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.lightGreyText,
                  fontSize: 16.sp),
            ),
            Text(
              "On time feeding",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.lightGreyText,
                  fontSize: 16.sp),
            ),
            Text(
              "updates",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.lightGreyText,
                  fontSize: 16.sp),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            if (screen == 2) {
              Get.off(const SignupScreen());
            } else {
              setState(() {
                screen += 1;
              });
            }
          },
          child: Container(
            height: 50.h,
            width: 350.w,
            decoration: BoxDecoration(
                color: AppColors.orangeButton,
                borderRadius: BorderRadius.circular(10.r)),
            child: Row(
              children: [
                const Spacer(),
                Text(
                  buttonTextList[screen],
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  weight: 100.sp,
                  size: 20.sp,
                  color: const Color(0xFFFFFFFF),
                ),
                SizedBox(
                  width: 10.w,
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
              style: TextStyle(
                  color: Color.fromRGBO(161, 161, 161, 1),
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
            GestureDetector(
              onTap: () {
                log("Login tapped");
                Get.off(const Loginscreen());
              },
              child: const Text(
                "Login ",
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontSize: 15,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
