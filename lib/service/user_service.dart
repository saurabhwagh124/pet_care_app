import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart' as FB;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pet_care_app/model/address_model.dart';
import 'package:pet_care_app/model/user.dart';
import 'package:pet_care_app/network/api_endpoints.dart';

class UserService extends GetxService {
  String token = "";

  Future<User> fetchUserData(String email) async {
    final url = ApiEndpoints.getUserDataUrl.replaceAll("{MAIL}", email);
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        return User.fromJson(responseData);
      } else {
        throw Exception("else error in fetch user data${response.body}");
      }
    } catch (e) {
      throw Exception("catch error in fetch User Data $e");
    }
  }

  Future<bool> checkAdmin(String email) async {
    final url = ApiEndpoints.checkAdminUrl.replaceAll("{MAIL}", email);
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception("else error in check admin${response.body}");
      }
    } catch (e) {
      throw Exception("catch error in check admin $e");
    }
  }

  Future<List<AddressModel>> fetchUserAddress(String email) async {
    token = await FB.FirebaseAuth.instance.currentUser?.getIdToken() ?? "";
    final headers = {"Authorization": "Bearer $token"};
    final url = ApiEndpoints.getAddressUrl.replaceAll("{email}", email);
    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List<dynamic>;
        return data.map((json) => AddressModel.fromJson(json)).toList();
      } else {
        throw Exception("else error in fetch user address ${response.body}");
      }
    } catch (e) {
      throw Exception("catch error in fetch user address $e");
    }
  }

  Future<void> deleteUserAddress(int id) async {
    token = await FB.FirebaseAuth.instance.currentUser?.getIdToken() ?? "";
    final headers = {"Authorization": "Bearer $token"};
    final url = ApiEndpoints.deleteAddressUrl.replaceAll("{id}", id.toString());
    try {
      final response = await http.delete(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        Get.snackbar("Success", response.body,
            backgroundColor: const Color(0xFF69F0AE));
      } else {
        throw Exception("else error in delete user address: ${response.body}");
      }
    } catch (e) {
      throw Exception("catch error in delete user address: $e");
    }
  }

  Future<AddressModel> addUserAddress(AddressModel payload) async {
    try {
      log(payload.toString());
      token = await FB.FirebaseAuth.instance.currentUser?.getIdToken() ?? "";
      final headers = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      };
      final response = await http.post(
          Uri.parse(ApiEndpoints.postAddAddressUrl),
          headers: headers,
          body: jsonEncode(payload));
      log(response.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        return AddressModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("else error in add address service: ${response.body}");
      }
    } catch (e) {
      throw Exception("catch error in add address service $e");
    }
  }
}
