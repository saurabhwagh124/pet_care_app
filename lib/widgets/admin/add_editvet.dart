import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_care_app/controller/vet_doc_controller.dart';
import 'package:pet_care_app/model/vet_doc_model.dart';
import 'package:pet_care_app/service/upload_service.dart';

class AddVetScreen extends StatefulWidget {
  final VetDocModel? vet;

  const AddVetScreen({super.key, this.vet});

  @override
  State<AddVetScreen> createState() => _AddVetScreenState();
}

class _AddVetScreenState extends State<AddVetScreen> {
  final vetController = VetDocController();
  final uploadService = UploadService();
  XFile? images;

  late String selectedImages;
  Future<void> pickImages() async {
    final ImagePicker picker = ImagePicker();
    images = await picker.pickImage(source: ImageSource.gallery);

    if (images != null) {
      setState(() {});
    }
  }

  // void removeImage(int index) {
  //   setState(() {
  //   });
  // }

  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController specializationController = TextEditingController();

  final TextEditingController experienceYearsController = TextEditingController();

  final TextEditingController reviewScoreController = TextEditingController();

  final TextEditingController clinicNameController = TextEditingController();

  final TextEditingController startDayController = TextEditingController();

  final TextEditingController endDayController = TextEditingController();

  final TextEditingController startTimeController = TextEditingController();

  final TextEditingController closeTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Populate fields if editing
    if (widget.vet != null) {
      nameController.text = widget.vet!.name!;
      emailController.text = widget.vet!.email!;
      specializationController.text = widget.vet!.specialization!;
      experienceYearsController.text = widget.vet!.experienceYears.toString();
      clinicNameController.text = widget.vet!.clinicName!;
      reviewScoreController.text = widget.vet!.reviewScore.toString();
      startDayController.text = widget.vet!.startDay!;
      endDayController.text = widget.vet!.endDay!;
      startTimeController.text = widget.vet!.startTime!;
      closeTimeController.text = widget.vet!.closeTime!;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.vet == null ? 'Add Veterinarian' : 'Edit Veterinarian'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) => value!.isEmpty ? 'Name is required' : null,
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) => value!.isEmpty ? 'Email is required' : null,
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
                onPressed: pickImages,
                icon: const Icon(Icons.image),
                label: const Text("Select Images"),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    selectedImages = await uploadService.uploadImage(images!) ?? "";
                    addVet();
                  }
                },
                child: Text(widget.vet == null ? 'Add Veterinarian' : 'Update Veterinarian'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addVet() {
    if (selectedImages.isEmpty || selectedImages == "") {
      return;
    }
    final newVet = VetDocModel(
      id: 0,
      name: nameController.text,
      email: emailController.text,
      specialization: specializationController.text,
      experienceYears: 10, //int.parse(experienceYearsController.text),
      clinicName: clinicNameController.text,
      startDay: startDayController.text,
      endDay: endDayController.text,
      startTime: startTimeController.text,
      closeTime: closeTimeController.text,
      description: "ADD",
      reviewScore: 0,
      photoUrl: selectedImages,
      address: "ABC",
      fees: 240,
      noOfReviews: 0,
    );

    vetController.add(newVet);
    Get.back();
  }
}
