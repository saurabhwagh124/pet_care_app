import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/controller/boarding_controller.dart';
import 'package:pet_care_app/utils/app_colors.dart';
import 'package:pet_care_app/widgets/admin/add_edit_boarding.dart';
import 'package:pet_care_app/widgets/boarding_card.dart';

class BoardingManagementScreen extends StatefulWidget {
  const BoardingManagementScreen({super.key});

  @override
  State<BoardingManagementScreen> createState() => _BoardingManagementState();
}

class _BoardingManagementState extends State<BoardingManagementScreen> {
  final _boardingController = Get.find<BoardingController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _boardingController.fetchBoardings();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text(
          "Boarding Management",
          style: TextStyle(
              fontSize: 23, fontWeight: FontWeight.w600, color: Colors.white),
        ),
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
              child: Obx(() {
                final list = _boardingController.boardingList;
                return (_boardingController.isLoading.value)
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.green,
                        ),
                      )
                    : list.isEmpty
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.separated(
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 10.h),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) =>
                                BoardingCard(data: list[index]),
                            itemCount: list.length,
                          );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.add,
            size: 30,
          ),
          onPressed: () {
            Get.to(() => const AddEditBoardingScreen());
          }),
    );
  }
}
