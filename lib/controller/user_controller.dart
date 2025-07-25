import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart' as FB;
import 'package:get/get.dart';
import 'package:pet_care_app/model/address_model.dart';
import 'package:pet_care_app/model/users.dart';
import 'package:pet_care_app/service/user_service.dart';
import 'package:pet_care_app/utils/user_data.dart';

class UserController extends GetxController {
  final userService = UserService();
  Rx<Users?> finalUser = Rx<Users?>(null);
  RxBool isLoading = false.obs;
  final UserData _userData = UserData();
  final Rx<bool> admin = false.obs;
  RxList<AddressModel> addressList = <AddressModel>[].obs;

  Future<void> fetchUserData(String email) async {
    try {
      isLoading.value = true;
      Users temp = await userService.fetchUserData(email);
      bool isAdmin = temp.role == "ADMIN";
      _userData.write("admin", isAdmin);
      admin.value = isAdmin;
      _userData.write("userId", temp.id);
      _userData.write("user", jsonEncode(temp.toJson()));
      finalUser.value = temp;
      isLoading.value = false;
      log("Fetched user success ${_userData.read("user")} , ${_userData.read("admin")}");
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void fetchUserAddress() async {
    try {
      isLoading.value = true;
      String email = FB.FirebaseAuth.instance.currentUser?.email ?? "";
      addressList.value = await userService.fetchUserAddress(email);
      isLoading.value = false;
    } catch (e) {
      log("Error fetching user address controller: $e");
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

  void updateUserDetails(Users payload) async {
    try {
      isLoading.value = true;
      log("update users");
      finalUser.value = await userService.updateUserDetails(payload);
      isLoading.value = false;
    } catch (e) {
      throw Exception("Error in update user details: $e");
    }
  }
}
