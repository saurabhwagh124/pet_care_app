import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_care_app/controller/pet_services_controller.dart';
import 'package:pet_care_app/model/pet_services_model.dart';
import 'package:pet_care_app/service/upload_service.dart'; // Assuming you have this

class AddEditPetServiceScreen extends StatefulWidget {
  final PetServicesModel? service; // Pass service data if editing

  const AddEditPetServiceScreen({super.key, this.service});

  @override
  State<AddEditPetServiceScreen> createState() =>
      _AddEditPetServiceScreenState();
}

class _AddEditPetServiceScreenState extends State<AddEditPetServiceScreen> {
  final _petServicesController = Get.find<PetServicesController>();
  final _uploadService = UploadService(); // Assuming you have this
  final _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  // --- Text Controllers ---
  late TextEditingController _nameController;
  late TextEditingController _categoryController;
  late TextEditingController _feesController;
  late TextEditingController _descriptionController;
  late TextEditingController _emailController; // <<<--- ADDED EMAIL CONTROLLER

  // --- State for Images and Switch ---
  List<dynamic> _imageSources = [];
  bool _isOpen = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.service?.name ?? '');
    _categoryController =
        TextEditingController(text: widget.service?.category ?? '');
    _feesController =
        TextEditingController(text: widget.service?.fees?.toString() ?? '');
    _descriptionController =
        TextEditingController(text: widget.service?.description ?? '');
    _emailController = TextEditingController(
        text:
            widget.service?.email ?? ''); // <<<--- INITIALIZE EMAIL CONTROLLER
    _isOpen = widget.service?.open ?? true;

    if (widget.service != null) {
      _imageSources = List.from(widget.service!.photoUrl);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _feesController.dispose();
    _descriptionController.dispose();
    _emailController.dispose(); // <<<--- DISPOSE EMAIL CONTROLLER
    super.dispose();
  }

  Future<void> _pickImages() async {
    final List<XFile> pickedFiles = await _picker.pickMultiImage(
      imageQuality: 70,
    );
    if (pickedFiles.isNotEmpty) {
      setState(() {
        _imageSources.addAll(pickedFiles);
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _imageSources.removeAt(index);
    });
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      Get.snackbar("Validation Error", "Please correct the errors in the form.",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (_imageSources.isEmpty) {
      Get.snackbar("Error", "Please select at least one image for the service.",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    List<String> finalImageUrls = [];

    for (var source in _imageSources) {
      if (source is XFile) {
        try {
          final imageUrl = await _uploadService.uploadImage(source);
          if (imageUrl != null && imageUrl.isNotEmpty) {
            finalImageUrls.add(imageUrl);
          } else {
            Get.snackbar("Error", "An image upload failed. Please try again.",
                snackPosition: SnackPosition.BOTTOM);
            setState(() {
              _isLoading = false;
            });
            return;
          }
        } catch (e) {
          Get.snackbar("Error", "Image upload failed: ${e.toString()}",
              snackPosition: SnackPosition.BOTTOM);
          setState(() {
            _isLoading = false;
          });
          return;
        }
      } else if (source is String) {
        finalImageUrls.add(source);
      }
    }

    final serviceData = PetServicesModel(
      id: widget.service?.id ?? 0,
      email: _emailController.text,
      name: _nameController.text,
      category: _categoryController.text,
      fees: int.tryParse(_feesController.text) ?? 0,
      photoUrl: finalImageUrls,
      reviewScore: widget.service?.reviewScore ?? 0.0,
      noOfReviews: widget.service?.noOfReviews ?? 0,
      description: _descriptionController.text,
      createdAt: widget.service?.createdAt,
      open: _isOpen,
    );

    try {
      if (widget.service == null) {
        _petServicesController.addPetService(serviceData);
        Get.snackbar("Success", "Pet service added successfully!",
            snackPosition: SnackPosition.BOTTOM);
      } else {
        _petServicesController.updatePetService(
            serviceData); // Ensure this method exists and takes PetServicesModel
        Get.snackbar("Success", "Pet service updated successfully!",
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar("Error", "An operation failed: ${e.toString()}",
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      setState(() {
        _isLoading = false;
      });
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.service == null ? 'Add Pet Service' : 'Edit Pet Service'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextFormField(_nameController, 'Service Name',
                    isRequired: true),
                _buildTextFormField(_categoryController, 'Category',
                    isRequired: true),
                _buildTextFormField(_emailController, 'Contact Email',
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                  if (value != null &&
                      value.isNotEmpty &&
                      !GetUtils.isEmail(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                }),
                _buildTextFormField(_feesController, 'Fees',
                    keyboardType: TextInputType.number, isRequired: true),
                _buildTextFormField(_descriptionController, 'Description',
                    maxLines: 3),
                SwitchListTile(
                  title: const Text("Service Available (Open)"),
                  value: _isOpen,
                  onChanged: (val) => setState(() => _isOpen = val),
                  activeColor: Theme.of(context).primaryColor,
                ),
                const SizedBox(height: 16),
                const Text("Service Images:",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: _pickImages,
                  icon: const Icon(Icons.add_photo_alternate_outlined),
                  label: const Text("Select Images"),
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 40)),
                ),
                const SizedBox(height: 10),
                _buildImagePreview(),
                const SizedBox(height: 30),
                Center(
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: _submitForm,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 15),
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                          child: Text(widget.service == null
                              ? 'Add Service'
                              : 'Update Service'),
                        ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(
    TextEditingController controller,
    String label, {
    TextInputType keyboardType = TextInputType.text,
    bool isRequired = false,
    int? maxLines = 1,
    String? Function(String?)? validator, // <<<--- Allow custom validator
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
        validator: validator ??
            (value) {
              // Use custom validator if provided, else default
              if (isRequired && (value == null || value.isEmpty)) {
                return '$label is required';
              }
              // Default validation for fees (already exists in your original code)
              if (label.toLowerCase() == 'fees' &&
                  value != null &&
                  value.isNotEmpty &&
                  int.tryParse(value) == null) {
                return 'Please enter a valid number for fees';
              }
              return null;
            },
      ),
    );
  }

  Widget _buildImagePreview() {
    if (_imageSources.isEmpty) {
      return const Center(
          child: Text("No images selected.",
              style: TextStyle(color: Colors.grey)));
    }
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: List.generate(_imageSources.length, (index) {
        final imageSource = _imageSources[index];
        ImageProvider imageProvider;

        if (imageSource is XFile) {
          imageProvider = FileImage(File(imageSource.path));
        } else if (imageSource is String && imageSource.isNotEmpty) {
          imageProvider = NetworkImage(imageSource);
        } else {
          return Container(
              width: 80,
              height: 80,
              color: Colors.grey[300],
              child: const Icon(Icons.broken_image));
        }

        return Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                  onError: (exception, stackTrace) {
                    print("Error loading image: $exception");
                  },
                ),
              ),
            ),
            Positioned(
              right: -5,
              top: -5,
              child: InkWell(
                onTap: () => _removeImage(index),
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Colors.redAccent,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, color: Colors.white, size: 18),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
