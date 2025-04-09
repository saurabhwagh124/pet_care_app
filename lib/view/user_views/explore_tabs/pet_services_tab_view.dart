import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/controller/pet_services_controller.dart';
import 'package:pet_care_app/controller/vet_doc_controller.dart';
import 'package:pet_care_app/widgets/pet_services_card_widget.dart';

class PetServicesTabView extends StatefulWidget {
  const PetServicesTabView({super.key});

  @override
  State<PetServicesTabView> createState() => _PetServicesTabViewState();
}

class _PetServicesTabViewState extends State<PetServicesTabView> {
  final PetServicesController _controller = PetServicesController();
  final vetController = Get.find<VetDocController>();

  @override
  void initState() {
    _controller.fetchAllPetServices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Padding(
        //   padding: EdgeInsets.only(top: 10.h, left: 20.w, right: 20.w),
        //   child: Row(
        //     children: [
        //       Text(
        //         "Nearby Grooming room",
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
        SizedBox(
          height: 10.h,
        ),
        Expanded(
          // height: 300.h,
          child: Obx(() {
            final list = _controller.petServiceList
                .where((element) => element.name!
                    .toLowerCase()
                    .contains(vetController.search.value.toLowerCase()))
                .toList();
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) =>
                  PetServicesCardWidget(data: list[index]),
              itemCount: list.length,
            );
          }),
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
        //         "Recomended Grooming room",
        //         style: TextStyle(
        //             fontSize: 16.sp,
        //             fontWeight: FontWeight.w500,
        //             color: Colors.black),
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
        //   height: 10.h,
        // ),
        // Center(
        //   child: SizedBox(
        //     height: 300.h,
        //     child: ListView.builder(
        //       scrollDirection: Axis.vertical,
        //       itemBuilder: (context, index) =>
        //           GrommingCard(data: grooming[index]),
        //       itemCount: grooming.length,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
