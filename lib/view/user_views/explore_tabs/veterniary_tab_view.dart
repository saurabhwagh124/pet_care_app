import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/controller/vet_doc_controller.dart';
import 'package:pet_care_app/widgets/vet_card_widget.dart';

class VeterniaryTabView extends StatefulWidget {
  const VeterniaryTabView({super.key});

  @override
  State<VeterniaryTabView> createState() => _VeterniaryTabViewState();
}

class _VeterniaryTabViewState extends State<VeterniaryTabView> {
  final VetDocController _vetDocController = VetDocController();

  @override
  void initState() {
    super.initState();
    _vetDocController.fetchVetDocs();
    getId();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10.h, left: 20.w, right: 20.w),
          child: Row(
            children: [
              Text(
                "Veterinarian",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.black),
              ),
              const Spacer(),
            ],
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
        Expanded(
          child: Obx(
            () => ListView.separated(
              separatorBuilder: (context, index) => SizedBox(
                height: 10.h,
              ),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) => VetCardWidget(data: _vetDocController.vetDoctorsList[index]),
              itemCount: _vetDocController.vetDoctorsList.length,
            ),
          ),
        ),
        // const Divider(
        //   color: Colors.black,
        // ),
        // SizedBox(
        //   height: 15.h,
        // ),
        // Padding(
        //   padding: EdgeInsets.only(top: 10.h, left: 20.w, right: 20.w),
        //   child: Row(
        //     children: [
        //       Text(
        //         "Recommended Veterinarian",
        //         style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.black),
        //       ),
        //       const Spacer(),
        //       Text(
        //         "See all",
        //         style: TextStyle(
        //           color: AppColors.greyTextColor,
        //           fontSize: 12.sp,
        //           fontWeight: FontWeight.w400,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // SizedBox(
        //   height: 15.h,
        // ),
        // Center(
        //   child: SizedBox(
        //     height: 260.h,
        //     child: ListView.separated(
        //       separatorBuilder: (context, index) {
        //         return const Divider();
        //       },
        //       scrollDirection: Axis.vertical,
        //       itemBuilder: (context, index) => VetCardWidget(data: doctorList[index]),
        //       itemCount: doctorList.length,
        //     ),
        //   ),
        // )
      ],
    );
  }

  void getId() async {
    final user = FirebaseAuth.instance.currentUser!;
    final id = await user.getIdToken();
    // log("user $user");
    log(id ?? "");
  }
}
