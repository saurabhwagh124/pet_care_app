import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
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
      log("Fetching data");
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
}
