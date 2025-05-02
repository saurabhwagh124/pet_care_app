import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/utils/app_colors.dart';

class Deliveryscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 25.sp),
            onPressed: () => Get.back(),
          ),
          backgroundColor: AppColors.yellowCircle,
          title: Text('Parks Management')),
      body: Center(child: Text('Parks Management Screen')),
    );
  }
}
