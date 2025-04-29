import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pet_care_app/model/all_appointments_model.dart';
import 'package:pet_care_app/model/boarding_appointment_model.dart';
import 'package:pet_care_app/model/doctor_appointment_model.dart';
import 'package:pet_care_app/model/service_appointment_model.dart';
import 'package:pet_care_app/network/api_endpoints.dart';

class AppointmentsService extends GetxService {
  String token = "";

  Future<String> getToken() async {
    return await FirebaseAuth.instance.currentUser?.getIdToken() ?? "";
  }

  // FETCH TimeSlots Methods
  Future<List<String>> fetchBookedDoctorTimeSlots(
      int doctorId, String date) async {
    try {
      token = await FirebaseAuth.instance.currentUser?.getIdToken() ?? "";
      final headers = {"Authorization": "Bearer $token"};
      final url = ApiEndpoints.getDoctorAppointmentsSlotsUrl
          .replaceAll("{id}", doctorId.toString())
          .replaceAll("{date}", date);
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return List<String>.from(data);
      } else {
        throw Exception("Failed to load data: ${response.statusCode} ");
      }
    } catch (e) {
      throw Exception("Error fetching booked time slots doctor data: $e");
    }
  }

  Future<List<String>> fetchBookedServiceTimeSlots(
      int serviceId, String date) async {
    try {
      token = await FirebaseAuth.instance.currentUser?.getIdToken() ?? "";
      final headers = {"Authorization": "Bearer $token"};
      final url = ApiEndpoints.getServiceAppointmentsSlotsUrl
          .replaceAll("{id}", serviceId.toString())
          .replaceAll("{date}", date);
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return List<String>.from(data);
      } else {
        throw Exception("Failed to load data: ${response.statusCode} ");
      }
    } catch (e) {
      throw Exception("Error fetching booked time slots service data: $e");
    }
  }

  Future<List<String>> fetchBookedBoardingTimeSlots(
      int boardingId, String date) async {
    try {
      token = await FirebaseAuth.instance.currentUser?.getIdToken() ?? "";
      final headers = {"Authorization": "Bearer $token"};
      final url = ApiEndpoints.getBoardingAppointmentsSlotsUrl
          .replaceAll("{id}", boardingId.toString())
          .replaceAll("{date}", date);
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return List<String>.from(data);
      } else {
        throw Exception("Failed to load data: ${response.statusCode} ");
      }
    } catch (e) {
      throw Exception("Error fetching booked time slots boarding data: $e");
    }
  }

  // BOOK Appointment Methods
  Future<void> bookDoctorAppointment(DoctorAppointmentModel payload) async {
    try {
      token = await FirebaseAuth.instance.currentUser?.getIdToken() ?? "";
      final headers = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      };
      final newPayload = jsonEncode(payload.toJson());
      final response = await http.post(
          Uri.parse(ApiEndpoints.postDoctorAppointmentUrl),
          headers: headers,
          body: newPayload);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar("Success", "Appointment booked successfully",
            backgroundColor: Colors.lightGreenAccent);
      } else {
        throw Exception("Failed to load data: ${response.statusCode} ");
      }
    } catch (e) {
      throw Exception("Error booking doctor appointment: $e");
    }
  }

  Future<void> bookServiceAppointment(ServiceAppointmentModel payload) async {
    try {
      token = await FirebaseAuth.instance.currentUser?.getIdToken() ?? "";
      final headers = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      };
      final newPayload = jsonEncode(payload.toJson());
      final response = await http.post(
          Uri.parse(ApiEndpoints.postServiceAppointmentUrl),
          headers: headers,
          body: newPayload);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar("Success", "Appointment booked successfully",
            backgroundColor: Colors.lightGreenAccent);
      } else {
        throw Exception("Failed to load data: ${response.statusCode} ");
      }
    } catch (e) {
      throw Exception("Error booking Service appointment: $e");
    }
  }

  Future<void> bookBoardingAppointment(BoardingAppointmentModel payload) async {
    try {
      token = await FirebaseAuth.instance.currentUser?.getIdToken() ?? "";
      final headers = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      };
      final newPayload = jsonEncode(payload.toJson());
      final response = await http.post(
          Uri.parse(ApiEndpoints.postBoardingAppointmentUrl),
          headers: headers,
          body: newPayload);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar("Success", "Appointment booked successfully",
            backgroundColor: Colors.lightGreenAccent);
      } else {
        throw Exception("Failed to load data: ${response.statusCode} ");
      }
    } catch (e) {
      throw Exception("Error booking Service appointment: $e");
    }
  }

  Future<AllAppointmentsModel> fetchAllAppointments(int userId) async {
    try {
      token = await FirebaseAuth.instance.currentUser?.getIdToken() ?? "";
      final headers = {"Authorization": "Bearer $token"};
      final url = ApiEndpoints.getAllAppointmentsUrl
          .replaceAll("{ID}", userId.toString());
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // log("body${response.body}");
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        // log("data " + data.toString());
        return AllAppointmentsModel.fromJson(data);
      } else {
        throw Exception("Failed to load data: ${response.statusCode} ");
      }
    } catch (e) {
      throw Exception("Error Fetching all appointments: $e");
    }
  }
}
