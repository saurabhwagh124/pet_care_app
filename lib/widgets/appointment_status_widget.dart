import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pet_care_app/model/boarding_appointment_model.dart';
import 'package:pet_care_app/model/doctor_appointment_model.dart';
import 'package:pet_care_app/model/service_appointment_model.dart';

class AppointmentStatusWidget extends StatelessWidget {
  final bool isDoc;
  final bool isService;
  final bool isBoarding;
  final DoctorAppointmentModel? doctor;
  final ServiceAppointmentModel? service;
  final BoardingAppointmentModel? boarding;

  const AppointmentStatusWidget({super.key, this.isDoc = false, this.isService = false, this.isBoarding = false, this.doctor, this.boarding, this.service});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.sp),
      height: 40.h,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 4,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            getName(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          Text(
            DateFormat('dd MMM, yyyy').format(getDate()), // Formats date
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          Text(
            getTime(),
            style: const TextStyle(fontSize: 12, color: Colors.black),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _getStatusColor(getStatus()),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              getStatus(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String getName() {
    if (isDoc) {
      return doctor!.doctor!.clinicName!;
    } else if (isService) {
      return service!.service!.name!;
    } else {
      return boarding!.boarding!.name!;
    }
  }

  DateTime getDate() {
    if (isDoc) {
      return doctor!.date!;
    } else if (isService) {
      return service!.date!;
    } else {
      return boarding!.date!;
    }
  }

  String getTime() {
    if (isDoc) {
      return doctor!.time!;
    } else if (isService) {
      return service!.time!;
    } else {
      return boarding!.time!;
    }
  }
  String getStatus() {
    if (isDoc) {
      return doctor!.status!;
    } else if (isService) {
      return service!.status!;
    } else {
      return boarding!.status!;
    }
  }

  /// Determines the status color dynamically
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "confirmed":
        return Colors.green;
      case "pending":
        return Colors.orange;
      case "cancelled":
        return Colors.red;
      default:
        return Colors.blueGrey;
    }
  }
}

//  ListTile(
//                                   minTileHeight: 40.h,
//                                   title: Text("Name: ${controller.docAppointmentList[index].doctor!.clinicName}"),
//                                   subtitle: Text("Date: ${controller.docAppointmentList[index].date!.toLocal()}, Time: ${controller.docAppointmentList[index].time}"),
//                                   trailing: Text("Status: ${controller.docAppointmentList[index].status}"),
//                                 ),
