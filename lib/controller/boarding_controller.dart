import 'dart:developer';

import 'package:get/get.dart';
import 'package:pet_care_app/model/boarding_model.dart';
import 'package:pet_care_app/service/boarding_service.dart';

class BoardingController extends GetxController {
  final BoardingService boardingService = BoardingService();
  RxList<BoardingModel> boardingList = <BoardingModel>[].obs;

  void fetchBoardings() async {
    try {
      boardingList.value = await boardingService.fetchBoardings();
    } catch (e) {
      log("Error fetching Boarding list: $e");
    }
  }

  void addBoarding(BoardingModel boarding) {
    boardingList.add(boarding);
  }

  void deleteBoarding(int index) {
    boardingList.removeAt(index);
  }

  void updateBoarding(int index, BoardingModel updatedBoarding) {
    boardingList[index] = updatedBoarding;
  }
}
