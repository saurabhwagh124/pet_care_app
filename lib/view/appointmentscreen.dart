import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/controller/appointment_controller.dart';
import 'package:pet_care_app/utils/app_colors.dart';
import 'package:pet_care_app/widgets/admin/boarding_appointment_card.dart';
import 'package:pet_care_app/widgets/admin/doctor_appointment_card.dart';
import 'package:pet_care_app/widgets/admin/service_appointment_card.dart';

class AppointmentsScreen extends StatefulWidget {
  final int id;
  final bool isBoarding;
  final bool isDoctor;
  final bool isService;
  const AppointmentsScreen(
      {super.key,
      required this.id,
      this.isBoarding = false,
      this.isDoctor = false,
      this.isService = false});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  final controller = Get.find<AppointmentController>();

  @override
  void initState() {
    super.initState();
    if (widget.isBoarding) {
      controller.fetchBoardingAppointments(widget.id);
    } else if (widget.isDoctor) {
      controller.fetchDoctorAppointments(widget.id);
    } else {
      controller.fetchServiceAppointments(widget.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scheduled Appointments"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 25.sp),
          onPressed: () => Get.back(),
        ),
        backgroundColor: AppColors.yellowCircle,
      ),
      body: getAppointments(),
      
    );
  }

  Widget getAppointments() {
    return Obx(() {
      if (widget.isBoarding) {
        final list = controller.boardingAppointmentList;
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.green,
            ),
          );
        } else {
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
        }
      } else if (widget.isDoctor) {
        final list = controller.docAppointmentList;
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.green,
            ),
          );
        } else {
          return ListView.builder(
            itemBuilder: (context, index) => DoctorAppointmentCard(
                appointment: list[index],
                onApprove: () {
                  controller.confirmDoctor(
                      list[index].appointmentId ?? 0, index);
                },
                onCancel: () {
                  controller.cancelDoctor(
                      list[index].appointmentId ?? 0, index);
                }),
            itemCount: list.length,
          );
        }
      } else {
        final list = controller.serviceAppointmentList;
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.green,
            ),
          );
        } else {
          return ListView.builder(
            itemBuilder: (context, index) => ServiceAppointmentCard(
                appointment: list[index],
                onApprove: () {
                  controller.confirmService(
                      list[index].appointmentId ?? 0, index);
                },
                onCancel: () {
                  controller.cancelService(
                      list[index].appointmentId ?? 0, index);
                }),
            itemCount: list.length,
          );
        }
      }
    });
  }
}
