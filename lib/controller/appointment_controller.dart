import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:pet_care_app/model/all_appointments_model.dart';
import 'package:pet_care_app/model/boarding_appointment_model.dart';
import 'package:pet_care_app/model/boarding_model.dart';
import 'package:pet_care_app/model/doctor_appointment_model.dart';
import 'package:pet_care_app/model/pet_services_model.dart';
import 'package:pet_care_app/model/service_appointment_model.dart';
import 'package:pet_care_app/model/user.dart';
import 'package:pet_care_app/model/user_pet_model.dart';
import 'package:pet_care_app/model/vet_doc_model.dart';
import 'package:pet_care_app/service/appointments_service.dart';
import 'package:pet_care_app/utils/user_data.dart';

class AppointmentController extends GetxController {
  final AppointmentsService appointmentsService = AppointmentsService();
  RxBool isLoading = false.obs;
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
      isLoading.value = true;
      bookedTimeSlots.value =
          await appointmentsService.fetchBookedDoctorTimeSlots(doctorId, date);
      isLoading.value = false;
    } catch (e) {
      log("Error fetching booked time slots doctor data: $e");
    }
  }

  void fetchBookedServiceTimeSlots(int serviceId, String date) async {
    try {
      isLoading.value = true;
      bookedTimeSlots.value = await appointmentsService
          .fetchBookedServiceTimeSlots(serviceId, date);
      isLoading.value = false;
    } catch (e) {
      log("Error fetching booked time slots service data: $e");
    }
  }

  void fetchBookedBoardingTimeSlots(int boardingId, String date) async {
    try {
      isLoading.value = true;
      bookedTimeSlots.value = await appointmentsService
          .fetchBookedBoardingTimeSlots(boardingId, date);
      isLoading.value = false;
    } catch (e) {
      log("Error fetching booked time slots boarding data: $e");
    }
  }

  void bookDoctorAppointment(VetDocModel doctor, UserPetModel pet,
      DateTime date, String selectedTime) async {
    isLoading.value = true;
    User user = User.fromJson(jsonDecode(userData.read<String>("user") ?? ""));
    final payload = DoctorAppointmentModel(
        appointmentId: 0,
        users: user,
        pet: pet,
        date: date,
        time: selectedTime,
        status: 'PENDING',
        doctor: doctor);
    log(jsonEncode(payload.toJson()));
    await appointmentsService.bookDoctorAppointment(payload);
    isLoading.value = false;
  }

  void bookServiceAppointment(PetServicesModel service, UserPetModel pet,
      DateTime date, String selectedTime) {
    isLoading.value = true;
    User user = User.fromJson(jsonDecode(userData.read<String>("user") ?? ""));
    final payload = ServiceAppointmentModel(
        appointmentId: 0,
        users: user,
        pet: pet,
        date: date,
        time: selectedTime,
        status: 'PENDING',
        service: service);
    log(jsonEncode(payload.toJson()));
    appointmentsService.bookServiceAppointment(payload);
    isLoading.value = false;
  }

  void bookBoardingAppointment(BoardingModel boarding, UserPetModel pet,
      DateTime date, String selectedTime) {
    isLoading.value = true;
    User user = User.fromJson(jsonDecode(userData.read<String>("user") ?? ""));
    final payload = BoardingAppointmentModel(
        appointmentId: 0,
        users: user,
        pet: pet,
        date: date,
        time: selectedTime,
        status: 'PENDING',
        boarding: boarding);
    log(jsonEncode(payload.toJson()));
    appointmentsService.bookBoardingAppointment(payload);
    isLoading.value = false;
  }

  void fetchAllAppointments() async {
    isLoading.value = true;
    int userId = userData.read<int>("userId") ?? 0;
    allAppointments = await appointmentsService.fetchAllAppointments(userId);
    docAppointmentList.value = allAppointments!.doctor.reversed.toList();
    boardingAppointmentList.value = allAppointments!.boarding.reversed.toList();
    serviceAppointmentList.value = allAppointments!.service.reversed.toList();
    log("All Appointments is null ${allAppointments.toString()}");
    isLoading.value = false;
  }

  void confirmBoarding(int appointmentId, int index) async {
    isLoading.value = true;
    BoardingAppointmentModel temp = BoardingAppointmentModel.fromJson(
        jsonDecode(await appointmentsService.confirmAppointments(appointmentId,
            boarding: true)));
    boardingAppointmentList.insert(index, temp);
    isLoading.value = false;
  }

  void cancelBoarding(int appointmentId, int index) async {
    isLoading.value = true;
    boardingAppointmentList.removeAt(index);
    await appointmentsService.cancelAppointments(appointmentId, boarding: true);
    isLoading.value = false;
  }

  void confirmDoctor(int appointmentId, int index) async {
    isLoading.value = true;
    DoctorAppointmentModel temp = DoctorAppointmentModel.fromJson(jsonDecode(
        await appointmentsService.confirmAppointments(appointmentId,
            doctor: true)));
    docAppointmentList.insert(index, temp);
    isLoading.value = false;
  }

  void cancelDoctor(int appointmentId, int index) async {
    isLoading.value = true;
    docAppointmentList.removeAt(index);
    await appointmentsService.cancelAppointments(appointmentId, doctor: true);
    isLoading.value = false;
  }

  void confirmService(int appointmentId, int index) async {
    isLoading.value = true;
    ServiceAppointmentModel temp = ServiceAppointmentModel.fromJson(jsonDecode(
        await appointmentsService.confirmAppointments(appointmentId,
            service: false)));
    serviceAppointmentList.insert(index, temp);
    isLoading.value = false;
  }

  void cancelService(int appointmentId, int index) async {
    isLoading.value = true;
    serviceAppointmentList.removeAt(index);
    await appointmentsService.cancelAppointments(appointmentId, service: false);
    isLoading.value = false;
  }

  void fetchBoardingAppointments(int id) async {
    isLoading.value = true;
    boardingAppointmentList.value =
        await appointmentsService.fetchBoardingAppointment(id);
    isLoading.value = false;
  }

  void fetchDoctorAppointments(int id) async {
    isLoading.value = true;
    docAppointmentList.value =
        await appointmentsService.fetchDoctorAppointment(id);
    isLoading.value = false;
  }

  void fetchServiceAppointments(int id) async {
    isLoading.value = true;
    serviceAppointmentList.value =
        await appointmentsService.fetchServiceAppointment(id);
    isLoading.value = false;
  }
}
