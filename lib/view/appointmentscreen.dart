import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/controller/appointment_controller.dart';
import 'package:pet_care_app/utils/app_colors.dart';
import 'package:pet_care_app/widgets/admin/boarding_appointment_card.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  final controller = Get.find<AppointmentController>();

  @override
  void initState() {
    super.initState();
    controller.fetchAllAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Scheduled Appointments",
          style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white),
        ),
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        backgroundColor: AppColors.yellowCircle,
      ),
      body: Obx(() {
        final list = controller.boardingAppointmentList;
        return ListView.builder(
          itemBuilder: (context, index) => BoardingAppointmentCard(
              appointment: list[index],
              onApprove: () {
                controller.confirmBoarding(
                    list[index].appointmentId ?? 0, index);
              },
              onCancel: () {
                controller.cancelBoarding(
                    list[index].appointmentId ?? 0, index);
              }),
          itemCount: list.length,
        );
      }),
    );
  }
}
