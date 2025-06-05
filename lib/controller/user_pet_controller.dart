import 'dart:developer';

import 'package:get/get.dart';
import 'package:pet_care_app/model/user_pet_model.dart';
import 'package:pet_care_app/service/user_pet_service.dart';
import 'package:pet_care_app/utils/enums.dart';

class UserPetController extends GetxController {
  final UserPetService service = UserPetService();
  RxList<UserPetModel> userPetList = <UserPetModel>[].obs;
  RxBool isLoading = false.obs;

  void fetchUserPets() async {
    try {
      isLoading.value = true;
      userPetList.value = await service.fetchUserPets();
      isLoading.value = false;
    } catch (e) {
      log("Error fetching user pet list: $e");
    }
  }

  void addUserPet(UserPetModel payload) async {
    try {
      isLoading.value = true;
      UserPetModel response = await service.addPetToUser(payload);
      userPetList.add(response);
      isLoading.value = false;
    } catch (e) {
      log("Error adding pet to user: $e");
    }
  }

  Future<UserPetModel> editUserPet(UserPetModel payload) async {
    try {
      isLoading.value = true;
      userPetList.removeWhere((element) => element.id == payload.id);
      UserPetModel response = await service.editPet(payload);
      userPetList.add(response);
      isLoading.value = false;
      return response;
    } catch (e) {
      throw Exception("error editing pet information: $e");
    }
  }

  void deletePet(int id) {
    try {
      isLoading.value = true;
      service.deletePet(id);
      userPetList.removeWhere((element) => element.id == id);
      isLoading.value = false;
    } catch (e) {
      log("Error deleting pet: $e");
    }
  }
}
