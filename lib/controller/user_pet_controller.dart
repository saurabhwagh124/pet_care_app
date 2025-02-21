import 'dart:developer';

import 'package:get/get.dart';
import 'package:pet_care_app/model/user_pet_model.dart';
import 'package:pet_care_app/service/user_pet_service.dart';
import 'package:pet_care_app/utils/enums.dart';

class UserPetController extends GetxController {
  final UserPetService service = UserPetService();
  RxList<UserPetModel> userPetList = <UserPetModel>[].obs;
  ApiStatus userPetListStatus = ApiStatus.LOADING;
  ApiStatus addPetStatus = ApiStatus.LOADING;
  ApiStatus editPetStatus = ApiStatus.LOADING;

  void fetchUserPets() async {
    try {
      userPetList.value = await service.fetchUserPets();
      userPetListStatus = ApiStatus.SUCCESS;
    } catch (e) {
      userPetListStatus = ApiStatus.ERROR;
      log("Error fetching user pet list: $e");
    }
  }

  void addUserPet(UserPetModel payload) async {
    try {
      UserPetModel response = await service.addPetToUser(payload);
      userPetList.add(response);
      addPetStatus = ApiStatus.SUCCESS;
    } catch (e) {
      addPetStatus = ApiStatus.ERROR;
      log("Error adding pet to user: $e");
    }
  }

  Future<UserPetModel> editUserPet(UserPetModel payload) async {
    try {
      userPetList.removeWhere((element) => element.id == payload.id);
      UserPetModel response = await service.editPet(payload);
      userPetList.add(response);
      editPetStatus = ApiStatus.SUCCESS;
      return response;
    } catch (e) {
      editPetStatus = ApiStatus.ERROR;
      throw Exception("error editing pet information: $e");
    }
  }
}
