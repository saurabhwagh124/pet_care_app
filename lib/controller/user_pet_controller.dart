import 'dart:developer';

import 'package:get/get.dart';
import 'package:pet_care_app/model/user_pet_model.dart';
import 'package:pet_care_app/service/user_pet_service.dart';

class UserPetController extends GetxController {
  final UserPetService service = UserPetService();
  RxList<UserPetModel> userPetList = <UserPetModel>[].obs;

  void fetchUserPets() async {
    try {
      userPetList.value = await service.fetchUserPets();
    } catch (e) {
      log("Error fetching user pet list: $e");
    }
  }
}
