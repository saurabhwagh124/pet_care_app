import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care_app/model/grooming_model.dart';
import 'package:pet_care_app/utils/app_colors.dart';
import 'package:pet_care_app/utils/app_images.dart';
import 'package:pet_care_app/widgets/gromming_card_widget.dart';

class GroomTabView extends StatefulWidget {
  const GroomTabView({super.key});

  @override
  State<GroomTabView> createState() => _GroomTabViewState();
}

class _GroomTabViewState extends State<GroomTabView> {
  List<GroomingModel> grooming = [
    GroomingModel(
      name: 'Comb and Collar',
      imageUrl: AppImages.combAndCollarImg,
      rating: 5.0,
      reviewCount: 100,
      isOpen: true,
      distance: 2.5,
      price: 100,
      hours: 'Monday - Friday at 8.00 am - 5.00 pm',
    ),
    GroomingModel(
      name: 'Cosmo Dog Cares',
      imageUrl: AppImages.cosmoDogCaresImg,
      rating: 3.5,
      reviewCount: 20,
      isOpen: true,
      distance: 2,
      price: 150,
      hours: 'Monday - Friday at 8.00 am - 6.00 pm',
    ),
    GroomingModel(
      name: 'Dirty Paws Dog Spa',
      imageUrl: AppImages.dirtyPawDogSpaImg,
      rating: 4.5,
      reviewCount: 75,
      isOpen: false,
      distance: 4,
      price: 100,
      hours: 'Monday - Friday at 9.00 am - 6.00 pm',
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
                "Nearby Grooming room",
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
          height: 10.h,
        ),
        Center(
          child: SizedBox(
            height: 300.h,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) => GrommingCard(data: grooming[index]),
              itemCount: grooming.length,
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
                "Recomended Grooming room",
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
          height: 10.h,
        ),
        Center(
          child: SizedBox(
            height: 300.h,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) => GrommingCard(data: grooming[index]),
              itemCount: grooming.length,
            ),
          ),
        ),
      ],
    );
  }
}
