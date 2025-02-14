import 'dart:developer';

import 'package:get/get.dart';
import 'package:pet_care_app/model/vet_doc_model.dart';
import 'package:pet_care_app/service/vet_doc_service.dart';

class VetDocController extends GetxController {
  final VetDocService _vetDocService = VetDocService();
  RxList<VetDocModel> vetDoctorsList = <VetDocModel>[].obs;

  void fetchVetDocs() async {
    try {
      vetDoctorsList.value = await _vetDocService.fetchVetDoctors();
    } catch (e) {
      log("Error fetching vet doctors list: $e");
    }
  }

  RxList<VetDocModel> vets = <VetDocModel>[].obs;

  // Map to track assigned appointments
  RxMap<String, String> appointments = <String, String>{}.obs; // {TimeSlot: VetName}

  // Add or Edit Veterinarian
  void add(VetDocModel vet) async {
    final response = await _vetDocService.addVet(vet);
    vets.add(response!);
  }

  // Assign a vet to a specific time slot
  bool assignVetToAppointment(String vetName, String timeSlot) {
    if (appointments.containsKey(timeSlot)) {
      if (appointments[timeSlot] == vetName) {
        Get.snackbar('Error', '$vetName is already assigned to this time slot.');
        return false;
      }
      Get.snackbar('Error', 'This time slot is already assigned to another vet.');
      return false;
    }

    // Assign the vet to the time slot
    appointments[timeSlot] = vetName;
    return true;
  }

  // Delete Veterinarian
  void deleteVet(VetDocModel vet) {
    vets.remove(vet);
  }
}
