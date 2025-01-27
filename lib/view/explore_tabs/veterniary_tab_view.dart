import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care_app/model/vet_doctor_model.dart';
import 'package:pet_care_app/utils/app_colors.dart';
import 'package:pet_care_app/utils/app_images.dart';
import 'package:pet_care_app/widgets/vet_card_widget.dart';

class VeterniaryTabView extends StatefulWidget {
  const VeterniaryTabView({super.key});

  @override
  State<VeterniaryTabView> createState() => _VeterniaryTabViewState();
}

class _VeterniaryTabViewState extends State<VeterniaryTabView> {
  @override
  void initState() {
    super.initState();
    getId();
  }

  List<VetDoctorModel> doctorList = [
    VetDoctorModel(
      name: 'Rafeeqa',
      profileImg: AppImages.docRafeeqaImg,
      degree: 'Bsc. of Veterinary Science',
      yearsOfExp: 10,
      distance: 2.5,
      startDay: 'Monday',
      endDay: 'Friday',
      reviewStars: 4.5,
      numberOfReview: 34,
      fees: 300,
      startTime: 9.00,
      endTime: 6.30,
    ),
    VetDoctorModel(
      name: 'Arham',
      profileImg: AppImages.docArhamImg,
      degree: 'Veterinary Dentist',
      yearsOfExp: 4,
      distance: 1.5,
      startDay: 'Monday',
      endDay: 'Friday',
      reviewStars: 4.2,
      numberOfReview: 44,
      fees: 400,
      startTime: 8.00,
      endTime: 5.00,
    ),
    VetDoctorModel(
      name: 'Natasha',
      profileImg: AppImages.docNatashaImg,
      degree: 'Bsc. of Veterinary Science',
      yearsOfExp: 7,
      distance: 5,
      startDay: 'Monday',
      endDay: 'Friday',
      reviewStars: 4.2,
      numberOfReview: 67,
      fees: 300,
      startTime: 9.00,
      endTime: 6.00,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10.h, left: 20.w, right: 20.w),
          child: Row(
            children: [
              Text(
                "Nearby Veterinarian",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.black),
              ),
              const Spacer(),
              Text(
                "See all",
                style: TextStyle(
                  color: AppColors.greyTextColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
        Center(
          child: SizedBox(
            height: 260.h,
            child: ListView.separated(
              // shrinkWrap: true,
              separatorBuilder: (context, index) => SizedBox(
                height: 10.h,
              ),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) => VetCardWidget(data: doctorList[index]),
              itemCount: doctorList.length,
            ),
          ),
        ),
        const Divider(
          color: Colors.black,
        ),
        SizedBox(
          height: 15.h,
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.h, left: 20.w, right: 20.w),
          child: Row(
            children: [
              Text(
                "Recommended Veterinarian",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.black),
              ),
              const Spacer(),
              Text(
                "See all",
                style: TextStyle(
                  color: AppColors.greyTextColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
        Center(
          child: SizedBox(
            height: 260.h,
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return const Divider();
              },
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) => VetCardWidget(data: doctorList[index]),
              itemCount: doctorList.length,
            ),
          ),
        )
      ],
    );
  }

  void getId() async {
    final user = FirebaseAuth.instance.currentUser!;
    final id = await user.getIdToken();
    log("user $user");
    log(id ?? "");
  }
}
