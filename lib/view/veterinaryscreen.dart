import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/controller/vet_doc_controller.dart';
import 'package:pet_care_app/widgets/admin/add_editvet.dart';
import 'package:pet_care_app/widgets/admin/assignvet.dart';

class Veterinaryscreen extends StatefulWidget {
  const Veterinaryscreen({super.key});

  @override
  State<Veterinaryscreen> createState() => _VeterinaryscreenState();
}

class _VeterinaryscreenState extends State<Veterinaryscreen> {
  final vetController = VetDocController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Veterinarian List'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(), // Navigate back to the previous screen
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              final vets = vetController.vets;

              if (vets.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('No veterinarians available.'),
                      SizedBox(height: 16),
                      // ElevatedButton(
                      //   onPressed: () => Get.to(() => AddVetScreen()),
                      //   child: Text('Add Veterinarian'),
                      // ),
                    ],
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: vets.length,
                  itemBuilder: (context, index) {
                    final vet = vets[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: ListTile(
                        title: Text("Name: ${vet.name}"),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Email: ${vet.email}'),
                            Text('Specialization: ${vet.specialization}'),
                            Text('Experience: ${vet.experienceYears} years'),
                            Text('Clinic: ${vet.clinicName}'),
                            Text('Start Day: ${vet.startDay}'),
                            Text('End Day: ${vet.endDay}'),
                            Text('Start Time: ${vet.startTime}'),
                            Text('Close Time: ${vet.closeTime}'),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Pass vet details to AssignVetScreen
                                Get.to(() => AssignVetScreen(), arguments: vet);
                              },
                              child: const Text('Assign Appointment'),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                vetController.deleteVet(vet); // Delete vet
                              },
                            ),
                          ],
                        ),
                        onTap: () {
                          Get.to(() => AddVetScreen(vet: vet)); // Edit vet
                        },
                      ),
                    );
                  },
                );
              }
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () => Get.to(() => const AddVetScreen()),
              child: const Text('Add Veterinarian'),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: ElevatedButton(
          //     onPressed: () => Get.to(() => AssignVetScreen(),),
          //     child: Text('Assign Veterinarian'),
          //   ),
          // ),
        ],
      ),
    );
  }
}
