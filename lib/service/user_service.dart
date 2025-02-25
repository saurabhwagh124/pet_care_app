import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pet_care_app/model/user.dart';
import 'package:pet_care_app/network/api_endpoints.dart';

class UserService extends GetxService {
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
}
