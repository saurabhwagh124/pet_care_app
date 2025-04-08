import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/controller/appointment_controller.dart';
import 'package:pet_care_app/utils/app_colors.dart';
import 'package:pet_care_app/widgets/appointment_status_widget.dart';

class ScheduledAppointmentsScreen extends StatefulWidget {
  const ScheduledAppointmentsScreen({super.key});

  @override
  State<ScheduledAppointmentsScreen> createState() => _ScheduledAppointmentsScreenState();
}

class _ScheduledAppointmentsScreenState extends State<ScheduledAppointmentsScreen> {
  final controller = AppointmentController();
  ValueNotifier<bool> isDoc = ValueNotifier(false);
  ValueNotifier<bool> isBoarding = ValueNotifier(false);
  ValueNotifier<bool> isService = ValueNotifier(false);

  @override
  void initState() {
    controller.fetchAllAppointments();
    log(controller.allAppointments.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Scheduled Appointments",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        backgroundColor: AppColors.yellowCircle,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  isDoc.value = !isDoc.value;
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Colors.orangeAccent[200], borderRadius: BorderRadius.circular(15.r)),
                  height: 30.h,
                  margin: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 50.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Doctors Appointments"),
                      ValueListenableBuilder(valueListenable: isDoc, builder: (context, value, _) => (value) ? const Icon(Icons.arrow_drop_up) : const Icon(Icons.arrow_drop_down))
                    ],
                  ),
                ),
              ),
              ValueListenableBuilder(
                  valueListenable: isDoc,
                  builder: (context, value, _) => (value)
                      ? SizedBox(
                          height: controller.docAppointmentList.length * 50.h,
                          child: Obx(() => ListView.builder(
                                itemBuilder: (context, index) => AppointmentStatusWidget(
                                  isDoc: true,
                                  doctor: controller.docAppointmentList[index],
                                ),
                                itemCount: controller.docAppointmentList.length,
                              )),
                        )
                      : const SizedBox.shrink()),
              GestureDetector(
                onTap: () {
                  isService.value = !isService.value;
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Colors.orangeAccent[200], borderRadius: BorderRadius.circular(15.r)),
                  height: 30.h,
                  margin: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 50.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Services Appointments"),
                      ValueListenableBuilder(valueListenable: isService, builder: (context, value, _) => (value) ? const Icon(Icons.arrow_drop_up) : const Icon(Icons.arrow_drop_down))
                    ],
                  ),
                ),
              ),
              ValueListenableBuilder(
                  valueListenable: isService,
                  builder: (context, value, _) => (value)
                      ? SizedBox(
                          height: controller.serviceAppointmentList.length * 50.h,
                          child: Obx(() => ListView.builder(
                                itemBuilder: (context, index) => AppointmentStatusWidget(
                                  isService: true,
                                  service: controller.serviceAppointmentList[index],
                                ),
                                itemCount: controller.serviceAppointmentList.length,
                              )),
                        )
                      : const SizedBox.shrink()),
              GestureDetector(
                onTap: () {
                  isBoarding.value = !isBoarding.value;
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Colors.orangeAccent[200], borderRadius: BorderRadius.circular(15.r)),
                  height: 30.h,
                  margin: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 50.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Boarding Appointments"),
                      ValueListenableBuilder(valueListenable: isBoarding, builder: (context, value, _) => (value) ? const Icon(Icons.arrow_drop_up) : const Icon(Icons.arrow_drop_down))
                    ],
                  ),
                ),
              ),
              ValueListenableBuilder(
                  valueListenable: isBoarding,
                  builder: (context, value, _) => (value)
                      ? SizedBox(
                          height: controller.boardingAppointmentList.length * 50.h,
                          child: Obx(() => ListView.builder(
                                itemBuilder: (context, index) => AppointmentStatusWidget(
                                  isBoarding: true,
                                  boarding: controller.boardingAppointmentList[index],
                                ),
                                itemCount: controller.boardingAppointmentList.length,
                              )),
                        )
                      : const SizedBox.shrink()),
            ],
          ),
        ),
      ),
    );
  }
}
