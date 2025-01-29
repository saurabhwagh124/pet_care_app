import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care_app/model/boarding_model.dart';
import 'package:pet_care_app/utils/app_colors.dart';
import 'package:pet_care_app/utils/app_images.dart';
import 'package:pet_care_app/widgets/boarding_card.dart';

class BoardingTabView extends StatefulWidget {
  const BoardingTabView({super.key});

  @override
  State<BoardingTabView> createState() => _BoardingTabViewState();
}

class _BoardingTabViewState extends State<BoardingTabView> {
  List<BoardingModel> boardingList = [
    BoardingModel(
        name: "Tails of the city",
        imageUrl: AppImages.tailsOfTheCityImg,
        distance: 2.5,
        startDay: 'Monday',
        endDay: 'Friday',
        endTime: 5.00,
        startTime: 8.00,
        isOpen: true,
        price: 100,
        rating: 3.5,
        reviewCount: 95)
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Nearby Boarding",
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
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
              itemBuilder: (context, index) =>
                  BoardingCard(data: boardingList[index]),
              itemCount: boardingList.length,
            ),
          ),
        ),
      ],
    );
  }
}
