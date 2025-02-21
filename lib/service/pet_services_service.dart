import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
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
      final response = await http.get(Uri.parse(ApiEndpoints.getAllPetServicesUrl), headers: headers);
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
}
