import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care_app/utils/app_colors.dart';
import 'package:pet_care_app/utils/app_images.dart';

class VetCardWidget extends StatelessWidget {
  const VetCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130.h,
      width: 280.w,
      decoration:
          BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(10.r), boxShadow: [BoxShadow(color: Colors.black, offset: Offset(0, 1.h), blurRadius: 4.r, spreadRadius: 0)]),
      padding: EdgeInsets.all(10.sp),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 60.w,
                child: Image.asset(AppImages.arfaPersonImg),
              )
            ],
          )
        ],
      ),
    );
  }
}
