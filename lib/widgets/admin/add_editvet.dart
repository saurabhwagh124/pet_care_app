import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_care_app/controller/vet_doc_controller.dart';
import 'package:pet_care_app/model/vet_doc_model.dart';
import 'package:pet_care_app/service/upload_service.dart';

void showAddVetBottomSheet(BuildContext context, {VetDocModel? vet}) {
  final vetController = VetDocController();
  final uploadService = UploadService();
  final ImagePicker picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final specializationController = TextEditingController();
  final experienceYearsController = TextEditingController();
  final reviewScoreController = TextEditingController();
  final clinicNameController = TextEditingController();
  final startDayController = TextEditingController();
  final endDayController = TextEditingController();
  final startTimeController = TextEditingController();
  final closeTimeController = TextEditingController();

  XFile? selectedImage;
  String uploadedImageUrl = "";

  if (vet != null) {
    nameController.text = vet.name ?? "";
    emailController.text = vet.email ?? "";
    specializationController.text = vet.specialization ?? "";
    experienceYearsController.text = vet.experienceYears.toString();
    reviewScoreController.text = vet.reviewScore.toString();
    clinicNameController.text = vet.clinicName ?? "";
    startDayController.text = vet.startDay ?? "";
    endDayController.text = vet.endDay ?? "";
    startTimeController.text = vet.startTime ?? "";
    closeTimeController.text = vet.closeTime ?? "";
    uploadedImageUrl = vet.photoUrl ?? "";
  }

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 24,
        ),
        child: StatefulBuilder(
          builder: (context, setState) {
            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      vet == null ? 'Add Veterinarian' : 'Edit Veterinarian',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: 'Name'),
                      validator: (value) => value!.isEmpty ? 'Required' : null,
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: (value) => value!.isEmpty ? 'Required' : null,
                    ),
                    TextFormField(
                      controller: specializationController,
                      decoration: const InputDecoration(labelText: 'Specialization'),
                    ),
                    TextFormField(
                      controller: reviewScoreController,
                      decoration: const InputDecoration(labelText: 'Review Score'),
                      keyboardType: TextInputType.number,
                    ),
                    TextFormField(
                      controller: experienceYearsController,
                      decoration: const InputDecoration(labelText: 'Experience (Years)'),
                      keyboardType: TextInputType.number,
                    ),
                    TextFormField(
                      controller: clinicNameController,
                      decoration: const InputDecoration(labelText: 'Clinic Name'),
                    ),
                    TextFormField(
                      controller: startDayController,
                      decoration: const InputDecoration(labelText: 'Start Day'),
                    ),
                    TextFormField(
                      controller: endDayController,
                      decoration: const InputDecoration(labelText: 'End Day'),
                    ),
                    TextFormField(
                      controller: startTimeController,
                      decoration: const InputDecoration(labelText: 'Start Time'),
                    ),
                    TextFormField(
                      controller: closeTimeController,
                      decoration: const InputDecoration(labelText: 'Close Time'),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () async {
                        final image = await picker.pickImage(source: ImageSource.gallery);
                        if (image != null) {
                          setState(() => selectedImage = image);
                        }
                      },
                      icon: const Icon(Icons.image),
                      label: const Text("Select Image"),
                    ),
                    if (selectedImage != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Image.file(File(selectedImage!.path), height: 100),
                      ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (selectedImage != null) {
                            uploadedImageUrl =
                                await uploadService.uploadImage(selectedImage!) ?? "";
                          }

                          if (uploadedImageUrl.isEmpty) {
                            Get.snackbar("Error", "Image upload failed or not selected");
                            return;
                          }

                          final newVet = VetDocModel(
                            id: vet?.id ?? 0,
                            name: nameController.text,
                            email: emailController.text,
                            specialization: specializationController.text,
                            experienceYears: int.tryParse(experienceYearsController.text) ?? 0,
                            clinicName: clinicNameController.text,
                            startDay: startDayController.text,
                            endDay: endDayController.text,
                            startTime: startTimeController.text,
                            closeTime: closeTimeController.text,
                            description: "ADD",
                            reviewScore: double.tryParse(reviewScoreController.text) ?? 0,
                            photoUrl: uploadedImageUrl,
                            address: "ABC",
                            fees: 240,
                            noOfReviews: 0,
                          );

                          if (vet == null) {
                            vetController.add(newVet);
                          } else {
                            // vetController.updateVet(newVet);
                          }

                          Get.back(); // Close bottom sheet
                        }
                      },
                      child: Text(vet == null ? 'Add Veterinarian' : 'Update Veterinarian'),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
