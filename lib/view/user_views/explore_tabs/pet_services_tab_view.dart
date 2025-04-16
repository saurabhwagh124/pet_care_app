import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/controller/pet_services_controller.dart';
import 'package:pet_care_app/controller/vet_doc_controller.dart';
import 'package:pet_care_app/widgets/pet_services_card_widget.dart';

class PetServicesTabView extends StatefulWidget {
  const PetServicesTabView({super.key});

  @override
  State<PetServicesTabView> createState() => _PetServicesTabViewState();
}

class _PetServicesTabViewState extends State<PetServicesTabView> {
  final PetServicesController _controller = PetServicesController();
  final vetController = Get.find<VetDocController>();

  @override
  void initState() {
    _controller.fetchAllPetServices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final list = _controller.petServiceList
          .where((element) => element.name!
              .toLowerCase()
              .contains(vetController.search.value.toLowerCase()))
          .toList();
      return ListView.builder(
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) =>
            PetServicesCardWidget(data: list[index]),
        itemCount: list.length,
      );
    });
  }
}
