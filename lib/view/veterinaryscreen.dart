import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/controller/vet_doc_controller.dart';
import 'package:pet_care_app/utils/app_colors.dart';
import 'package:pet_care_app/widgets/vet_card_widget.dart';

class Veterinaryscreen extends StatefulWidget {
  const Veterinaryscreen({super.key});

  @override
  State<Veterinaryscreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<Veterinaryscreen> {
  final VetDocController _vetDocController = VetDocController();

  @override
  void initState() {
    super.initState();
    _vetDocController.fetchVetDocs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        //backgroundColor: AppColors.yellowCircle,
     title: Text("Veterinary"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          
            
            SizedBox(height: 15.h),
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w),
           
            ),
            SizedBox(height: 15.h),
            Expanded(
              child: Obx(
                () => _vetDocController.vetDoctorsList.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.separated(
                        separatorBuilder: (context, index) => SizedBox(height: 10.h),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) => VetCardWidget(data: _vetDocController.vetDoctorsList[index]),
                        itemCount: _vetDocController.vetDoctorsList.length,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabIcon(String imagePath, String label) {
    return Column(
      children: [
        Container(
          height: 40.h,
          width: 40.w,
          padding: EdgeInsets.all(10.sp),
          decoration: BoxDecoration(
            color: AppColors.greyIconBox,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Image.asset(imagePath),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: AppColors.greyTextColor),
        ),
      ],
    );
  }

  void getId() async {
    final user = FirebaseAuth.instance.currentUser!;
    final id = await user.getIdToken();
    log(id ?? "");
  }
}
