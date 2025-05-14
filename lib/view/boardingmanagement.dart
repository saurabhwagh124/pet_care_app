import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/controller/boarding_controller.dart';
import 'package:pet_care_app/model/boarding_model.dart';
import 'package:pet_care_app/utils/app_colors.dart';
import 'package:pet_care_app/widgets/admin/add_edit_boarding.dart';
import 'package:pet_care_app/widgets/boarding_card.dart';

class BoardingManagementScreen extends StatefulWidget {
  const BoardingManagementScreen({super.key});

  @override
  State<BoardingManagementScreen> createState() => _BoardingManagementState();
}

class _BoardingManagementState extends State<BoardingManagementScreen> {
  final BoardingController _boardingController = BoardingController();

  void showBoardingBottomSheet(BuildContext context,
      {BoardingModel? boarding, int? index}) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      context: context,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: BoardingFormBottomSheet(boarding: boarding, index: index),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _boardingController.fetchBoardings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text("Boarding Management"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 25.sp),
          onPressed: () => Get.back(),
        ),
        backgroundColor: AppColors.yellowCircle,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15.h),
            Expanded(
              child: Obx(
                () => _boardingController.boardingList.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.separated(
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 10.h),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) => BoardingCard(
                            data: _boardingController.boardingList[index]),
                        itemCount: _boardingController.boardingList.length,
                      ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        showBoardingBottomSheet(context);
      }),
    );
  }
}
