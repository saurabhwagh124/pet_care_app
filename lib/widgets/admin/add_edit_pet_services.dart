import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../controller/pet_service_controller.dart';
import '../../model/pet_services_model.dart';

class AddEditPetServicePage extends StatefulWidget {
  final int? index;
  final PetServicesModel? service;

  const AddEditPetServicePage({super.key, this.index, this.service});

  @override
  _AddEditPetServicePageState createState() => _AddEditPetServicePageState();
}

class _AddEditPetServicePageState extends State<AddEditPetServicePage> {
  final PetServicesController controller = Get.find();
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController feesController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isOpen = true;
  List<String> selectedImages = [];

  @override
  void initState() {
    super.initState();
    if (widget.service != null) {
      nameController.text = widget.service!.name ?? "";
      categoryController.text = widget.service!.category ?? "";
      feesController.text = widget.service!.fees?.toString() ?? "";
      descriptionController.text = widget.service!.description ?? "";
      isOpen = widget.service!.open ?? true;
      selectedImages = List.from(widget.service!.photoUrl);
    }
  }

  Future<void> pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> images = await picker.pickMultiImage();

    setState(() {
      selectedImages.addAll(images.map((img) => img.path));
    });
  }

  void removeImage(int index) {
    setState(() {
      selectedImages.removeAt(index);
    });
  }

  void savePetService() {
    if (_formKey.currentState!.validate()) {
      final newService = PetServicesModel(
        id: widget.service?.id ?? DateTime.now().millisecondsSinceEpoch,
        email: "admin@example.com",
        name: nameController.text,
        category: categoryController.text,
        fees: int.parse(feesController.text),
        photoUrl: selectedImages,
        reviewScore: 0.0,
        noOfReviews: 0,
        description: descriptionController.text,
        createdAt: DateTime.now(),
        open: isOpen,
      );

      if (widget.index != null) {
        controller.updatePetService(widget.index!, newService);
      } else {
        controller.addPetService(newService);
      }

      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.service != null ? "Edit Service" : "Add Service")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: "Service Name"),
                  validator: (value) => value!.isEmpty ? "Enter service name" : null,
                ),
                TextFormField(
                  controller: categoryController,
                  decoration: const InputDecoration(labelText: "Category"),
                  validator: (value) => value!.isEmpty ? "Enter category" : null,
                ),
                TextFormField(
                  controller: feesController,
                  decoration: const InputDecoration(labelText: "Fees"),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? "Enter fees" : null,
                ),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: "Description"),
                ),
                SwitchListTile(
                  title: const Text("Open"),
                  value: isOpen,
                  onChanged: (val) => setState(() => isOpen = val),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: pickImages,
                  icon: const Icon(Icons.image),
                  label: const Text("Select Images"),
                ),
                const SizedBox(height: 10),
                selectedImages.isNotEmpty
                    ? Wrap(
                        spacing: 10,
                        children: List.generate(selectedImages.length, (index) {
                          return Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Image.file(File(selectedImages[index]), width: 80, height: 80, fit: BoxFit.cover),
                              IconButton(
                                icon: const Icon(Icons.cancel, color: Colors.red),
                                onPressed: () => removeImage(index),
                              ),
                            ],
                          );
                        }),
                      )
                    : const Text("No images selected"),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: savePetService,
                  child: Text(widget.service != null ? "Update" : "Add"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
