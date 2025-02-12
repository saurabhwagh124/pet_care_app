import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/controller/boarding_controller.dart';
import 'package:pet_care_app/widgets/admin/add_edit_boarding.dart';

class BoardingManagementScreen extends StatelessWidget {
  BoardingManagementScreen({super.key});
  final BoardingController controller = BoardingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Boarding Services")),
      body: Obx(() {
        if (controller.boardingList.isEmpty) {
          return const Center(child: Text("No boarding services added yet."));
        }
        return ListView.builder(
          itemCount: controller.boardingList.length,
          itemBuilder: (context, index) {
            final boarding = controller.boardingList[index];
            return ListTile(
              title: Text(boarding.name ?? "No Name"),
              subtitle: Text("Fees: \$${boarding.fees}, Open: ${boarding.startTime}, Close: ${boarding.closeTime}"),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => controller.deleteBoarding(index),
              ),
              onTap: () => Get.to(() => BoardingFormView(boarding: boarding, index: index)),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => BoardingFormView()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
