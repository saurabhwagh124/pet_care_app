import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:pet_care_app/model/user.dart';
import 'package:pet_care_app/service/user_service.dart';
import 'package:pet_care_app/utils/user_data.dart';

class UserController extends GetxController {
  final userService = UserService();
  final UserData _userData = UserData();

  void fetchUserData(String email) async {
    try {
      User temp = await userService.fetchUserData(email);
      _userData.write("userId", temp.id);
      _userData.write("user", jsonEncode(temp.toJson()));
      log("Fetched user success ${_userData.read("user")}");
    } catch (e) {
      log("Error fetching user Data: $e");
    }
  }
}
