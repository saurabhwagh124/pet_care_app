import 'package:get/get.dart';

import '../model/pet_services_model.dart';

class PetServicesController extends GetxController {
  var petServicesList = <PetServicesModel>[].obs;

  // Temporary data (Replace with API calls later)
  @override
  void onInit() {
    super.onInit();
    fetchPetServices();
  }

  void fetchPetServices() {
    petServicesList.assignAll([
      PetServicesModel(
        id: 1,
        email: "petcare@example.com",
        name: "Happy Paws",
        category: "Grooming",
        fees: 500,
        photoUrl: ["bg.png", "bg.png", "bg.png"],
        reviewScore: 4.5,
        noOfReviews: 20,
        description: "Professional pet grooming services.",
        createdAt: DateTime.now(),
        open: true,
      ),
    ]);
  }

  void addPetService(PetServicesModel service) {
    petServicesList.add(service);
  }

  void updatePetService(int index, PetServicesModel updatedService) {
    petServicesList[index] = updatedService;
  }

  void deletePetService(int index) {
    petServicesList.removeAt(index);
  }
}
