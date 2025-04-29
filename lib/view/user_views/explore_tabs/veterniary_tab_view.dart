import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/controller/vet_doc_controller.dart';
import 'package:pet_care_app/widgets/vet_card_widget.dart';

class VeterniaryTabView extends StatefulWidget {
  const VeterniaryTabView({super.key});

  @override
  State<VeterniaryTabView> createState() => _VeterniaryTabViewState();
}

class _VeterniaryTabViewState extends State<VeterniaryTabView> {
  final VetDocController _vetDocController = VetDocController();

  @override
  void initState() {
    super.initState();
    _vetDocController.fetchVetDocs();
    // getId();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final search = _vetDocController.search.value;
      final list = _vetDocController.vetDoctorsList
          .where((element) =>
              (element.name ?? "").toLowerCase().contains(search.toLowerCase()))
          .toList();
      return ListView.separated(
        separatorBuilder: (context, index) => SizedBox(
          height: 10.h,
        ),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) => VetCardWidget(data: list[index]),
        itemCount: list.length,
      );
    });
  }

  void getId() async {
    final user = FirebaseAuth.instance.currentUser!;
    final id = await user.getIdToken();
    log(id ?? "");
  }
}
