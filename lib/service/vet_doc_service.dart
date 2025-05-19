import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pet_care_app/model/vet_doc_model.dart';
import 'package:pet_care_app/network/api_endpoints.dart';

class VetDocService extends GetxService {
  Future<List<VetDocModel>> fetchVetDoctors() async {
    try {
      final token = await FirebaseAuth.instance.currentUser?.getIdToken();
      final headers = {"Authorization": "Bearer $token"};
      final response = await http.get(Uri.parse(ApiEndpoints.getAllDoctorsUrl),
          headers: headers);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
        return data.map((json) => VetDocModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  Future<VetDocModel> addVet(VetDocModel vet) async {
    log("Vet service add vet method:${vet.toJson()}");
    try {
      final token = await FirebaseAuth.instance.currentUser?.getIdToken();
      final headers = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      };
      final response = await http.post(Uri.parse(ApiEndpoints.getAllDoctorsUrl),
          body: jsonEncode(vet), headers: headers);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        return VetDocModel.fromJson(json);
      } else {
        throw Exception(
            "Vet service add vet method: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      throw Exception("Vet service add vet method: $e");
    }
  }

  Future<VetDocModel> editVet(VetDocModel payload) async {
    try {
      final token = await FirebaseAuth.instance.currentUser?.getIdToken();
      final headers = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      };
      final response = await http.put(Uri.parse(ApiEndpoints.getAllDoctorsUrl),
          body: jsonEncode(payload), headers: headers);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        return VetDocModel.fromJson(json);
      } else {
        throw Exception(
            "Vet service edit vet method: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      throw Exception("Vet service edit vet method: $e");
    }
  }

  Future<void> deleteVet(int id) async {
    try {
      final token = await FirebaseAuth.instance.currentUser?.getIdToken();
      final headers = {"Authorization": "Bearer $token"};
      final url = "${ApiEndpoints.getAllDoctorsUrl}/$id";
      final response = await http.delete(Uri.parse(url), headers: headers);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar("Deleted", "Vet deleted successfully",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (e) {
      throw Exception("Vet service delete vet method: $e");
    }
  }
}
