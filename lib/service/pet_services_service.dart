import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pet_care_app/model/pet_services_model.dart';
import 'package:pet_care_app/network/api_endpoints.dart';

class PetServicesService extends GetxService {
  Future<List<PetServicesModel>> fetchPetServices() async {
    try {
      final token = await FirebaseAuth.instance.currentUser?.getIdToken();
      final headers = {"Authorization": "Bearer $token"};
      log("Fetching pet services: ${ApiEndpoints.getAllPetServicesUrl}");
      final response = await http
          .get(Uri.parse(ApiEndpoints.getAllPetServicesUrl), headers: headers);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
        return data.map((json) => PetServicesModel.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load data : ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching data: $e");
    }
  }

  Future<PetServicesModel> addPetService(PetServicesModel service) async {
    try {
      final token = await FirebaseAuth.instance.currentUser?.getIdToken();
      final headers = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      };
      log("Fetching pet services: ${ApiEndpoints.getAllPetServicesUrl}");
      final response = await http.post(
          Uri.parse(ApiEndpoints.getAllPetServicesUrl),
          headers: headers,
          body: jsonEncode(service.toJson()));
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar("Added", "Service added successfully",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
        return PetServicesModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Failed to load data : ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching data: $e");
    }
  }

  Future<PetServicesModel> editPetService(PetServicesModel service) async {
    try {
      final token = await FirebaseAuth.instance.currentUser?.getIdToken();
      final headers = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      };
      log("Fetching pet services: ${ApiEndpoints.getAllPetServicesUrl}");
      final response = await http.put(
          Uri.parse(ApiEndpoints.getAllPetServicesUrl),
          headers: headers,
          body: jsonEncode(service.toJson()));
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar("Edited", "Service edited successfully",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
        return PetServicesModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Failed to load data : ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching data: $e");
    }
  }

  Future<void> deletePetService(int serviceId) async {
    try {
      final token = await FirebaseAuth.instance.currentUser?.getIdToken();
      final headers = {
        "Authorization": "Bearer $token",
      };
      log("Fetching pet services: ${ApiEndpoints.getAllPetServicesUrl}");
      final url = "${ApiEndpoints.getAllPetServicesUrl}/$serviceId";
      final response = await http.delete(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        Get.snackbar("Deleted", "Service deleted successfully",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      } else {
        Get.snackbar("Error", "Something went wrong",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (e) {
      throw Exception("Error fetching data: $e");
    }
  }
}
