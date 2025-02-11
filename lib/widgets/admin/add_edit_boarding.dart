import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/boarding_controller.dart';
import '../../model/boarding_model.dart';

class BoardingFormView extends StatelessWidget {
  final BoardingController controller = Get.find();
  final BoardingModel? boarding;
  final int? index;

  BoardingFormView({super.key, this.boarding, this.index});

  final nameController = TextEditingController();
  final feesController = TextEditingController();
  final contactController = TextEditingController();
  final addressController = TextEditingController();
  final startTimeController = TextEditingController();
  final closeTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (boarding != null) {
      nameController.text = boarding!.name ?? "";
      feesController.text = boarding!.fees.toString();
      contactController.text = boarding!.contact ?? "";
      addressController.text = boarding!.address ?? "";
      startTimeController.text = boarding!.startTime ?? "";
      closeTimeController.text = boarding!.closeTime ?? "";
    }

    return Scaffold(
      appBar: AppBar(title: Text(boarding == null ? "Add Boarding Service" : "Edit Boarding Service")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: "Name")),
            TextField(controller: feesController, decoration: const InputDecoration(labelText: "Fees"), keyboardType: TextInputType.number),
            TextField(controller: contactController, decoration: const InputDecoration(labelText: "Contact")),
            TextField(controller: addressController, decoration: const InputDecoration(labelText: "Address")),
            TextField(controller: startTimeController, decoration: const InputDecoration(labelText: "Open Time")),
            TextField(controller: closeTimeController, decoration: const InputDecoration(labelText: "Close Time")),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final updatedBoarding = BoardingModel(
                  id: boarding?.id ?? controller.boardingList.length + 1,
                  name: nameController.text,
                  email: "",
                  contact: contactController.text,
                  address: addressController.text,
                  fees: int.tryParse(feesController.text) ?? 0,
                  startDay: "Monday",
                  endDay: "Sunday",
                  reviewScore: 0.0,
                  noOfReviews: 0,
                  startTime: startTimeController.text,
                  closeTime: closeTimeController.text,
                  photoUrls: [],
                  createdAt: DateTime.now(),
                );

                if (boarding != null && index != null) {
                  controller.updateBoarding(index!, updatedBoarding);
                } else {
                  controller.addBoarding(updatedBoarding);
                }
                Get.back();
              },
              child: Text(boarding == null ? "Add Service" : "Update Service"),
            )
          ],
        ),
      ),
    );
  }
}
