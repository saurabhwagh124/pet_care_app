import 'dart:developer';

import 'package:get/get.dart';
import 'package:pet_care_app/model/boarding_model.dart';
import 'package:pet_care_app/service/boarding_service.dart';

class BoardingController extends GetxController {
  RxBool isLoading = true.obs;
  final BoardingService boardingService = BoardingService();
  RxList<BoardingModel> boardingList = <BoardingModel>[].obs;

  void fetchBoardings() async {
    try {
      isLoading.value = true;
      boardingList.value = await boardingService.fetchBoardings();
      isLoading.value = false;
    } catch (e) {
      log("Error fetching Boarding list: $e");
    }
  }

  void addBoarding(BoardingModel payload) async {
    try {
      isLoading.value = true;
      BoardingModel boarding = await boardingService.addBoarding(payload);
      boardingList.add(boarding);
      isLoading.value = false;
    } catch (e) {
      log(e.toString());
    }
  }

//Work on boarding service and add edit ui
  void deleteBoarding(int id) async {
    try {
      isLoading.value = true;
      await boardingService.deleteBoarding(id);
      boardingList.removeWhere((element) => element.id! == id);
      isLoading.value = false;
    } catch (e) {
      log(e.toString());
    }
  }

  void updateBoarding(BoardingModel updatedBoarding) async {
    try {
      isLoading.value = true;
      int index = boardingList
          .indexWhere((element) => element.id == updatedBoarding.id);
      boardingList[index] = await boardingService.editBoarding(updatedBoarding);
    } catch (e) {
      log(e.toString());
    }
  }
}
