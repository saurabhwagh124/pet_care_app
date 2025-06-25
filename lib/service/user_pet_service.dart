import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pet_care_app/model/user_pet_model.dart';
import 'package:pet_care_app/network/api_endpoints.dart';

class UserPetService extends GetxService {
  String token = "";

  @override
  Future<void> onInit() async {
    token = await FirebaseAuth.instance.currentUser?.getIdToken() ?? "";
    super.onInit();
  }

  Future<List<UserPetModel>> fetchUserPets() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      final headers = {"Authorization": "Bearer $token"};
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

  Future<UserPetModel> addPetToUser(UserPetModel payload) async {
    try {
      final headers = {"Authorization": "Bearer $token", "Content-Type": "application/json"};
      log(ApiEndpoints.postUserPetUrl);
      final response = await http.post(Uri.parse(ApiEndpoints.postUserPetUrl), headers: headers, body: jsonEncode(payload.toJson()));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return UserPetModel.fromJson(data);
      } else {
        throw Exception("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching data: $e");
    }
  }

  Future<UserPetModel> editPet(UserPetModel payload) async {
    try {
      final headers = {"Authorization": "Bearer $token", "Content-Type": "application/json"};
      log("Edit Pet Api");
      final response = await http.put(Uri.parse(ApiEndpoints.postUserPetUrl), headers: headers, body: jsonEncode(payload.toJson()));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return UserPetModel.fromJson(data);
      } else {
        throw Exception("Edit Request Failed");
      }
    } catch (e) {
      throw Exception("Edit Pet Api: $e");
    }
  }

  void deletePet(int id) async{
    try{
      final headers = {"Authorization": "Bearer $token", "Content-Type": "application/json"};
      final url = ApiEndpoints.deleteUserPetUrl.replaceAll("{id}", id.toString());
      final response = await http.delete(Uri.parse(url));
      if(response.statusCode == 200){
        Get.snackbar("Deleted", "pet deleted successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.5),
          colorText: Colors.white,
        );
      }
    }catch(e){
      throw Exception("Error deleting pet: $e");
    }
  }
}
