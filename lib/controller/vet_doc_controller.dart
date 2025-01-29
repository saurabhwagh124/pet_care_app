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
}
