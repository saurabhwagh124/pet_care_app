import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pet_care_app/model/doctor_appointment_model.dart';
import 'package:pet_care_app/network/api_endpoints.dart';

class AppointmentsService extends GetxService {
  String token = "";

  @override
  Future<void> onInit() async {
    token = await FirebaseAuth.instance.currentUser?.getIdToken() ?? "";
    super.onInit();
  }

  Future<List<String>> fetchBookedDoctorTimeSlots(int doctorId, String date) async {
    try {
      final headers = {"Authorization": "Bearer $token"};
      final url = ApiEndpoints.getDoctorAppointmentsSlotsUrl.replaceAll("{id}", doctorId.toString()).replaceAll("{date}", date);
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

  Future<void> bookDoctorAppointment(DoctorAppointment payload) async {
    try {
      token = await FirebaseAuth.instance.currentUser?.getIdToken() ?? "";
      final headers = {"Authorization": "Bearer $token", "Content-Type": "application/json"};
      final newPayload = jsonEncode(payload.toJson());
      final response = await http.post(Uri.parse(ApiEndpoints.postDoctorAppointmentUrl), headers: headers, body: newPayload);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar("Success", "Appointment booked successfully", backgroundColor: Colors.lightGreenAccent);
      } else {
        throw Exception("Failed to load data: ${response.statusCode} ");
      }
    } catch (e) {
      throw Exception("Error booking doctor appointment: $e");
    }
  }
}
