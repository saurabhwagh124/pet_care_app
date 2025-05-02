import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/controller/vet_doc_controller.dart';
import 'package:pet_care_app/utils/app_colors.dart';
import 'package:pet_care_app/widgets/vet_card_widget.dart';

class Veterinaryscreen extends StatefulWidget {
  const Veterinaryscreen({super.key});

  @override
  State<Veterinaryscreen> createState() => _VeterinaryscreenState();
}

class _VeterinaryscreenState extends State<Veterinaryscreen> {
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 25.sp),
          onPressed: () => Get.back(),
        ),
        backgroundColor: AppColors.yellowCircle,
        title: const Text("Veterinary"),
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
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 10.h),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) => VetCardWidget(
                            data: _vetDocController.vetDoctorsList[index]),
                        itemCount: _vetDocController.vetDoctorsList.length,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
