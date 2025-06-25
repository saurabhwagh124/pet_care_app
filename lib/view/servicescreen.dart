import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/controller/pet_services_controller.dart';
import 'package:pet_care_app/utils/app_colors.dart';
import 'package:pet_care_app/widgets/admin/add_edit_pet_services.dart';
import 'package:pet_care_app/widgets/pet_services_card_widget.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  final PetServicesController _controller = PetServicesController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.fetchAllPetServices();
    });
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
        title: Text(
          "Services",
          style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15.h),
            Expanded(
              child: Obx(() {
                final list = _controller.petServiceList;
                return (_controller.isLoading.value)
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.green,
                        ),
                      )
                    : _controller.petServiceList.isEmpty
                        ? const Center(
                            child: Text(
                            "No services available",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ))
                        : ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) =>
                                PetServicesCardWidget(data: list[index]),
                            itemCount: list.length,
                          );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const AddEditPetServiceScreen());
        },
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }

  void getId() async {
    final user = FirebaseAuth.instance.currentUser!;
    final id = await user.getIdToken();
    log(id ?? "");
  }
}
