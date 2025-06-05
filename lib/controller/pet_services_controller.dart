import 'dart:developer';

import 'package:get/get.dart';
import 'package:pet_care_app/model/pet_services_model.dart';
import 'package:pet_care_app/service/pet_services_service.dart';

class PetServicesController extends GetxController {
  final PetServicesService petServicesService = PetServicesService();
  RxBool isLoading = false.obs;
  RxList<PetServicesModel> petServiceList = <PetServicesModel>[].obs;

  void fetchAllPetServices() async {
    try {
      isLoading.value = true;
      petServiceList.value = await petServicesService.fetchPetServices();
      isLoading.value = false;
    } catch (e) {
      log("Error Fetching pet services list: $e");
    }
  }

  void addPetService(PetServicesModel service) async {
    try {
      isLoading.value = true;
      petServiceList.add(await petServicesService.addPetService(service));
      isLoading.value = false;
    } catch (e) {
      log("Error Fetching pet services list: $e");
    }
  }

  void updatePetService(PetServicesModel updatedService) async {
    try {
      isLoading.value = true;
      int index = petServiceList
          .indexWhere((service) => service.id == updatedService.id);
      petServiceList[index] =
          await petServicesService.editPetService(updatedService);
      isLoading.value = false;
    } catch (e) {
      log(e.toString());
    }
  }

  void deletePetService(int id) async {
    try {
      isLoading.value = true;
      await petServicesService.deletePetService(id);
      petServiceList.removeWhere((service) => service.id! == id);
      isLoading.value = false;
    } catch (e) {
      log(e.toString());
    }
  }
}
