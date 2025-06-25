import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/controller/boarding_controller.dart';
import 'package:pet_care_app/controller/vet_doc_controller.dart';
import 'package:pet_care_app/widgets/boarding_card.dart';

class BoardingTabView extends StatefulWidget {
  const BoardingTabView({super.key});

  @override
  State<BoardingTabView> createState() => _BoardingTabViewState();
}

class _BoardingTabViewState extends State<BoardingTabView> {
  final BoardingController _boardingController = BoardingController();
  final controller = Get.find<VetDocController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
    _boardingController.fetchBoardings();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final search = controller.search.value;
      final list = _boardingController.boardingList
          .where((element) =>
              element.name!.toLowerCase().contains(search.toLowerCase()))
          .toList();
      return (list.isEmpty) ?const Center(child: Text("No Boardings Found", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),) : ListView.builder(
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) => BoardingCard(data: list[index]),
        itemCount: list.length,
      );
    });
  }
}
