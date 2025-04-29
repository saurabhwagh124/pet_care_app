import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:pet_care_app/model/all_appointments_model.dart';
import 'package:pet_care_app/model/boarding_appointment_model.dart';
import 'package:pet_care_app/model/boarding_model.dart';
import 'package:pet_care_app/model/doctor_appointment_model.dart';
import 'package:pet_care_app/model/pet_services_model.dart';
import 'package:pet_care_app/model/service_appointment_model.dart';
import 'package:pet_care_app/model/vet_doc_model.dart';
import 'package:pet_care_app/service/appointments_service.dart';
import 'package:pet_care_app/utils/user_data.dart';

class AppointmentController extends GetxController {
  final AppointmentsService appointmentsService = AppointmentsService();
  RxList<String> bookedTimeSlots = <String>[].obs;
  UserData userData = UserData();
  RxList<DoctorAppointmentModel> docAppointmentList =
      <DoctorAppointmentModel>[].obs;
  RxList<BoardingAppointmentModel> boardingAppointmentList =
      <BoardingAppointmentModel>[].obs;
  RxList<ServiceAppointmentModel> serviceAppointmentList =
      <ServiceAppointmentModel>[].obs;
  AllAppointmentsModel? allAppointments;

  // Time Slot Methods

  void fetchBookedDoctorTimeSlots(int doctorId, String date) async {
    try {
      bookedTimeSlots.value =
          await appointmentsService.fetchBookedDoctorTimeSlots(doctorId, date);
    } catch (e) {
      log("Error fetching booked time slots doctor data: $e");
    }
  }

  void fetchBookedServiceTimeSlots(int serviceId, String date) async {
    try {
      bookedTimeSlots.value = await appointmentsService
          .fetchBookedServiceTimeSlots(serviceId, date);
    } catch (e) {
      log("Error fetching booked time slots service data: $e");
    }
  }

  void fetchBookedBoardingTimeSlots(int boardingId, String date) async {
    try {
      bookedTimeSlots.value = await appointmentsService
          .fetchBookedBoardingTimeSlots(boardingId, date);
    } catch (e) {
      log("Error fetching booked time slots boarding data: $e");
    }
  }

  void bookDoctorAppointment(
      VetDocModel doctor, int petId, DateTime date, String selectedTime) async {
    int userId = userData.read<int>("userId") ?? 0;
    final payload = DoctorAppointmentModel(
        appointmentId: 0,
        usersId: userId,
        petsId: petId,
        date: date,
        time: selectedTime,
        status: 'PENDING',
        doctor: doctor);
    log(jsonEncode(payload.toJson()));
    await appointmentsService.bookDoctorAppointment(payload);
  }

  void bookServiceAppointment(
      PetServicesModel service, int petId, DateTime date, String selectedTime) {
    int userId = userData.read<int>("userId") ?? 0;
    final payload = ServiceAppointmentModel(
        appointmentId: 0,
        usersId: userId,
        petsId: petId,
        date: date,
        time: selectedTime,
        status: 'PENDING',
        service: service);
    log(jsonEncode(payload.toJson()));
    appointmentsService.bookServiceAppointment(payload);
  }

  void bookBoardingAppointment(
      BoardingModel boarding, int petId, DateTime date, String selectedTime) {
    int userId = userData.read<int>("userId") ?? 0;
    final payload = BoardingAppointmentModel(
        appointmentId: 0,
        usersId: userId,
        petsId: petId,
        date: date,
        time: selectedTime,
        status: 'PENDING',
        boarding: boarding);
    log(jsonEncode(payload.toJson()));
    appointmentsService.bookBoardingAppointment(payload);
  }

  void fetchAllAppointments() async {
    int userId = userData.read<int>("userId") ?? 0;
    allAppointments = await appointmentsService.fetchAllAppointments(userId);
    docAppointmentList.value = allAppointments!.doctor.reversed.toList();
    boardingAppointmentList.value = allAppointments!.boarding.reversed.toList();
    serviceAppointmentList.value = allAppointments!.service.reversed.toList();
    log("All Appointments is null ${allAppointments.toString()}");
  }
}
