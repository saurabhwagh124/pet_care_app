import 'dart:developer';

import 'package:get/get.dart';
import 'package:pet_care_app/model/pet_services_model.dart';
import 'package:pet_care_app/service/pet_services_service.dart';

class PetServicesController extends GetxController {
  final PetServicesService petServicesService = PetServicesService();
  RxList<PetServicesModel> petServiceList = <PetServicesModel>[].obs;

  void fetchAllPetServices() async {
    try {
      petServiceList.value = await petServicesService.fetchPetServices();
    } catch (e) {
      log("Error Fetching pet services list: $e");
    }
  }
}
