import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/model/doctor_appointment_model.dart';
import 'package:pet_care_app/model/vet_doc_model.dart';
import 'package:pet_care_app/service/appointments_service.dart';
import 'package:pet_care_app/utils/user_data.dart';

class AppointmentController extends GetxController {
  final AppointmentsService appointmentsService = AppointmentsService();
  RxList<String> bookedTimeSlots = <String>[].obs;
  UserData userData = UserData();

  void fetchBookedDoctorTimeSlots(int doctorId, String date) async {
    try {
      bookedTimeSlots.value = await appointmentsService.fetchBookedDoctorTimeSlots(doctorId, date);
    } catch (e) {
      log("Error fetching booked time slots doctor data: $e");
    }
  }

  void bookDoctorAppointment(VetDocModel doctor, int petId, DateTime date, String selectedTime) async{
    int userId = userData.read<int>("userId") ?? 0;
    final payload = DoctorAppointment(appointmentId: 0, usersId: userId, petsId: petId, date: date, time: selectedTime, status: 'PENDING', doctor: doctor);
    log(jsonEncode(payload.toJson()));
    await appointmentsService.bookDoctorAppointment(payload);
  }

  void bookServiceAppointment(int serviceId, int petId, String date, String selectedTime) {}

  void bookBoardingAppointment(int boardingId, int petId, String date, String selectedTime) {}
}
