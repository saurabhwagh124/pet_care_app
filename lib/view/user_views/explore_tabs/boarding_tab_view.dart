import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/controller/boarding_controller.dart';
import 'package:pet_care_app/widgets/boarding_card.dart';

class BoardingTabView extends StatefulWidget {
  const BoardingTabView({super.key});

  @override
  State<BoardingTabView> createState() => _BoardingTabViewState();
}

class _BoardingTabViewState extends State<BoardingTabView> {
  final BoardingController _boardingController = BoardingController();

  @override
  void initState() {
    _boardingController.fetchBoardings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Row(
        //   children: [
        //     Text(
        //       "Nearby Boarding",
        //       style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.black),
        //     ),
        //     const Spacer(),
        //     Text(
        //       "See all",
        //       style: TextStyle(
        //         color: AppColors.greyTextColor,
        //         fontSize: 12.sp,
        //         fontWeight: FontWeight.w400,
        //       ),
        //     ),
        //   ],
        // ),
        Expanded(
          child: Obx(
            () => ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) => BoardingCard(data: _boardingController.boardingList[index]),
              itemCount: _boardingController.boardingList.length,
            ),
          ),
        ),
      ],
    );
  }
}
