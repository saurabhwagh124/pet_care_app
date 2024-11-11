import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care_app/model/vet_doctor_model.dart';
import 'package:pet_care_app/utils/app_colors.dart';
import 'package:pet_care_app/utils/app_images.dart';
import 'package:pet_care_app/widgets/vet_card_widget.dart';

class GroomTabView extends StatefulWidget {
  const GroomTabView({super.key});

  @override
  State<GroomTabView> createState() => _GroomTabViewState();
}

class _GroomTabViewState extends State<GroomTabView> {
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
      name: 'Rafeeqa 22',
      profileImg: AppImages.docRafeeqaImg,
      degree: 'Bsc. of Veterinary Science',
      yearsOfExp: 10,
      distance: 2.5,
      startDay: 'Monday',
      endDay: 'Friday',
      reviewStars: 3.2,
      numberOfReview: 34,
      fees: 300,
      startTime: 9.00,
      endTime: 6.30,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Nearby Grooming",
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.black),
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
        SizedBox(
          height: 50.h,
        ),
        Center(
          child: SizedBox(
            height: 300.h,
            child: ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) => VetCardWidget(data: doctorList[index]),
              itemCount: doctorList.length,
            ),
          ),
        ),
      ],
    );
  }
}
