import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:pet_care_app/model/address_model.dart';
import 'package:pet_care_app/model/user.dart';
import 'package:pet_care_app/service/user_service.dart';
import 'package:pet_care_app/utils/user_data.dart';

class UserController extends GetxController {
  final userService = UserService();
  RxBool isLoading = false.obs;
  final UserData _userData = UserData();
  final Rx<bool> admin = false.obs;
  RxList<AddressModel> addressList = <AddressModel>[].obs;

  void fetchUserData(String email) async {
    try {
      User temp = await userService.fetchUserData(email);
      bool isAdmin = temp.role == "ADMIN";
      _userData.write("admin", isAdmin);
      admin.value = isAdmin;
      _userData.write("userId", temp.id);
      _userData.write("user", jsonEncode(temp.toJson()));
      log("Fetched user success ${_userData.read("user")} , ${_userData.read("admin")}");
    } catch (e) {
      log("Error fetching user Data: $e");
    }
  }

  void fetchUserAddress(String email) async {
    try {
      isLoading.value = true;
      addressList.value = await userService.fetchUserAddress(email);
      isLoading.value = false;
    } catch (e) {
      log("Error fetching user address: $e");
    }
  }

  void deleteUserAddress(int id) async {
    try {
      await userService.deleteUserAddress(id);
    } catch (e) {
      log("Error deleting user address from controller $e");
    }
  }

  void addAddress(AddressModel payload) async {
    try {
      log("Add address start");
      addressList.add(await userService.addUserAddress(payload));
    } catch (e) {
      throw Exception("Error add address from controller $e");
    }
  }
}
