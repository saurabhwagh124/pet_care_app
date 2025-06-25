import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pet_care_app/model/boarding_model.dart';
import 'package:pet_care_app/network/api_endpoints.dart';

class BoardingService extends GetxService {
  Future<List<BoardingModel>> fetchBoardings() async {
    try {
      final token = await FirebaseAuth.instance.currentUser?.getIdToken();
      final headers = {"Authorization": "Bearer $token"};
      log(ApiEndpoints.getAllBoardingsUrl);
      final response = await http
          .get(Uri.parse(ApiEndpoints.getAllBoardingsUrl), headers: headers);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
        return data.map((json) => BoardingModel.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load data: ${response.statusCode} ");
      }
    } catch (e) {
      throw Exception("Error fetching data: $e");
    }
  }

  Future<BoardingModel> addBoarding(BoardingModel boarding) async {
    try {
      final token = await FirebaseAuth.instance.currentUser?.getIdToken();
      final headers = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      };
      log("Payload ${jsonEncode(boarding)}");
      final response = await http.post(
          Uri.parse(ApiEndpoints.getAllBoardingsUrl),
          headers: headers,
          body: jsonEncode(boarding.toJson()));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);
        Get.snackbar("Success", "Boarding service added successfully!",
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            backgroundColor: Colors.green);
        return BoardingModel.fromJson(responseBody);
      } else {
        throw Exception("Failed to add boarding : ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error adding boarding to db : ${e.toString()}");
    }
  }

  Future<BoardingModel> editBoarding(BoardingModel boarding) async {
    try {
      final token = await FirebaseAuth.instance.currentUser?.getIdToken();
      final headers = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      };
      log("Payload ${jsonEncode(boarding)}");
      final response = await http.post(
          Uri.parse(ApiEndpoints.getAllBoardingsUrl),
          headers: headers,
          body: jsonEncode(boarding.toJson()));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);
        Get.snackbar("Success", "Boarding service updated successfully!",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
        return BoardingModel.fromJson(responseBody);
      } else {
        throw Exception("Failed to add boarding : ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error adding boarding to db : ${e.toString()}");
    }
  }

  Future<void> deleteBoarding(int id) async {
    try {
      final token = await FirebaseAuth.instance.currentUser?.getIdToken();
      final header = {"Authorization": "Bearer $token"};
      final url = "${ApiEndpoints.getAllBoardingsUrl}/$id";
      final response = await http.delete(Uri.parse(url), headers: header);
      if (response.statusCode == 200) {
        Get.snackbar("Deleted", "Boarding deleted successfully",
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
      throw Exception("Error deleting boarding: ${e.toString()}");
    }
  }
}
