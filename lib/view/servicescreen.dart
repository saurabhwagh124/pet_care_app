import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/controller/pet_service_controller.dart';
import 'package:pet_care_app/widgets/admin/add_edit_pet_services.dart';

class ServicesScreen extends StatelessWidget {
  ServicesScreen({super.key});

  final PetServicesController controller = PetServicesController();
  Image _loadImage(String path) {
    if (path.startsWith("http")) {
      return Image.network(path, width: double.infinity, fit: BoxFit.cover);
    } else {
      return Image.file(File(path), width: double.infinity, fit: BoxFit.cover);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pet Services")),
      body: Obx(() {
        return ListView.builder(
          itemCount: controller.petServicesList.length,
          itemBuilder: (context, index) {
            final petService = controller.petServicesList[index];
            final PageController pageController = PageController();

            return Card(
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  if (petService.photoUrl.isNotEmpty)
                    SizedBox(
                      height: 200,
                      child: PageView.builder(
                        controller: pageController,
                        itemCount: petService.photoUrl.length,
                        itemBuilder: (context, imgIndex) {
                          return _loadImage(petService.photoUrl[imgIndex]);
                        },
                      ),
                    ),
                  ListTile(
                    title: Text(petService.name ?? ""),
                    subtitle: Text("${petService.category} • ₹${petService.fees}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              Get.to(() => AddEditPetServicePage(index: index, service: petService));
                            }),
                        IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              controller.deletePetService(index);
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Get.to(() => AddEditPetServicePage()),
      ),
    );
  }
}
