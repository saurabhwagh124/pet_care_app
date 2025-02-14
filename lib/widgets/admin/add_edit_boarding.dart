import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_care_app/controller/boarding_controller.dart';
import 'package:pet_care_app/model/boarding_model.dart';
import 'package:pet_care_app/service/upload_service.dart';

class BoardingFormView extends StatefulWidget {
  final BoardingModel? boarding;
  final int? index;
  const BoardingFormView({super.key, this.boarding, this.index});

  @override
  State<BoardingFormView> createState() => _BoardingFormViewState();
}

class _BoardingFormViewState extends State<BoardingFormView> {
  final formKey = GlobalKey<FormState>();
  final uploadService = UploadService();
  final controller = BoardingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final contactController = TextEditingController();
  final addressController = TextEditingController();
  final feesController = TextEditingController();
  final startDayController = TextEditingController();
  final endDayController = TextEditingController();
  final startTimeController = TextEditingController();
  final closeTimeController = TextEditingController();
  List<String> photoUrls = [];
  List<XFile> imagesList = [];
  final _picker = ImagePicker();

  Future<void> _pickImages() async {
    final List<XFile> pickedFiles = await _picker.pickMultiImage();
    setState(() {
      imagesList = pickedFiles;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.boarding != null) {
      nameController.text = widget.boarding!.name ?? "";
      emailController.text = widget.boarding!.email ?? "";
      contactController.text = widget.boarding!.contact ?? "";
      addressController.text = widget.boarding!.address ?? "";
      feesController.text = widget.boarding!.fees.toString();
      startDayController.text = widget.boarding!.startDay ?? "";
      endDayController.text = widget.boarding!.endDay ?? "";
      startTimeController.text = widget.boarding!.startTime ?? "";
      closeTimeController.text = widget.boarding!.closeTime ?? "";
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text(widget.boarding == null ? "Add Boarding Service" : "Edit Boarding Service")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              (imagesList.isEmpty)
                  ? SizedBox(
                      height: 50.h,
                      width: 50.w,
                      child: IconButton(
                          onPressed: _pickImages,
                          icon: const Icon(
                            Icons.image_outlined,
                            color: Colors.lightBlueAccent,
                          )),
                    )
                  : SizedBox(
                      height: 100.h,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: imagesList.length,
                          itemBuilder: (context, index) => Container(
                                width: 100.w,
                                padding: EdgeInsets.all(5.sp),
                                child: Image.file(File(imagesList[index].path)),
                              )),
                    ),
              TextFormField(controller: nameController, decoration: const InputDecoration(labelText: "Name")),
              TextFormField(controller: emailController, decoration: const InputDecoration(labelText: "Email")),
              TextFormField(controller: contactController, decoration: const InputDecoration(labelText: "Contact")),
              TextFormField(controller: addressController, decoration: const InputDecoration(labelText: "Address")),
              TextFormField(controller: feesController, decoration: const InputDecoration(labelText: "Fees"), keyboardType: TextInputType.number),
              TextFormField(controller: startDayController, decoration: const InputDecoration(labelText: "Start Day")),
              TextFormField(controller: endDayController, decoration: const InputDecoration(labelText: "End Day")),
              TextFormField(controller: startTimeController, decoration: const InputDecoration(labelText: "Open Time")),
              TextFormField(controller: closeTimeController, decoration: const InputDecoration(labelText: "Close Time")),
              SizedBox(height: 20.h),
              ElevatedButton(
                onPressed: () async {
                  photoUrls = await uploadService.uploadMultipleFiles(imagesList);
                  addBoarding();
                },
                child: Text(widget.boarding == null ? "Add Service" : "Update Service"),
              )
            ],
          ),
        ),
      ),
    );
  }

  void addBoarding() {
    final updatedBoarding = BoardingModel(
        id: widget.boarding?.id ?? 0,
        name: nameController.text,
        email: emailController.text,
        contact: contactController.text,
        address: addressController.text,
        fees: int.tryParse(feesController.text.trim()) ?? 0,
        startDay: startDayController.text,
        endDay: endDayController.text,
        reviewScore: 0.0,
        noOfReviews: 0,
        startTime: startTimeController.text,
        closeTime: closeTimeController.text,
        photoUrls: photoUrls,
        createdAt: null);
    if (widget.boarding != null && widget.index != null) {
      controller.updateBoarding(widget.index!, updatedBoarding);
    } else {
      controller.addBoarding(updatedBoarding);
    }
    Get.back();
  }
}
