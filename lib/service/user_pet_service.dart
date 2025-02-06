import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pet_care_app/model/user_pet_model.dart';
import 'package:pet_care_app/network/api_endpoints.dart';

class UserPetService extends GetxService {
  Future<List<UserPetModel>> fetchUserPets() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      final headers = {"Authorization": "Bearer ${user.getIdToken()}"};
      final url = ApiEndpoints.getAllPetsOfUserUrl.replaceAll("{userEmail}", user.email ?? "");
      log(url);
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
        return data.map((json) => UserPetModel.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching data: $e");
    }
  }
}
