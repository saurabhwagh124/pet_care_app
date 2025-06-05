import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_care_app/controller/vet_doc_controller.dart'; // Your GetX controller
import 'package:pet_care_app/model/vet_doc_model.dart'; // Your VetModel
import 'package:pet_care_app/service/upload_service.dart'; // Your UploadService

class AddEditVetScreen extends StatefulWidget {
  final VetDocModel? vet; // Pass vet data if editing

  const AddEditVetScreen({super.key, this.vet});

  @override
  State<AddEditVetScreen> createState() => _AddEditVetScreenState();
}

class _AddEditVetScreenState extends State<AddEditVetScreen> {
  final _vetController = Get.find<VetDocController>();
  final _uploadService = UploadService();
  final _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  // --- Text Controllers ---
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _specializationController;
  late TextEditingController _experienceYearsController;
  late TextEditingController _clinicNameController;
  late TextEditingController _descriptionController;
  late TextEditingController _addressController;
  late TextEditingController _feesController;

  // --- State for Dropdowns and Pickers ---
  XFile? _selectedImage;
  String? _uploadedImageUrl;

  final List<String> _daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  String? _selectedStartDay;
  String? _selectedEndDay;

  TimeOfDay? _selectedStartTime;
  TimeOfDay? _selectedCloseTime;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.vet?.name ?? '');
    _emailController = TextEditingController(text: widget.vet?.email ?? '');
    _specializationController =
        TextEditingController(text: widget.vet?.specialization ?? '');
    _experienceYearsController = TextEditingController(
        text: widget.vet?.experienceYears?.toString() ?? '');
    _clinicNameController =
        TextEditingController(text: widget.vet?.clinicName ?? '');
    _descriptionController =
        TextEditingController(text: widget.vet?.description ?? '');
    _addressController = TextEditingController(text: widget.vet?.address ?? '');
    _feesController =
        TextEditingController(text: widget.vet?.fees?.toString() ?? '');

    _uploadedImageUrl = widget.vet?.photoUrl;
    _selectedStartDay = widget.vet?.startDay;
    _selectedEndDay = widget.vet?.endDay;

    if (widget.vet != null) {
      // Safely parse start time
      if (widget.vet!.startTime != null && widget.vet!.startTime!.isNotEmpty) {
        try {
          _selectedStartTime = _timeOfDayFromString(widget.vet!.startTime!);
        } catch (e) {
          print(
              "Error parsing startTime '${widget.vet!.startTime}' in initState: $e");
          _selectedStartTime = null; // Default to null if parsing fails
        }
      }

      // Safely parse close time
      if (widget.vet!.closeTime != null && widget.vet!.closeTime!.isNotEmpty) {
        try {
          _selectedCloseTime = _timeOfDayFromString(widget.vet!.closeTime!);
        } catch (e) {
          print(
              "Error parsing closeTime '${widget.vet!.closeTime}' in initState: $e");
          _selectedCloseTime = null; // Default to null if parsing fails
        }
      }
    }

    // Ensure initial dropdown values for days are valid or null
    if (_selectedStartDay != null && !_daysOfWeek.contains(_selectedStartDay)) {
      _selectedStartDay = null;
    }
    if (_selectedEndDay != null && !_daysOfWeek.contains(_selectedEndDay)) {
      _selectedEndDay = null;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _specializationController.dispose();
    _experienceYearsController.dispose();
    _clinicNameController.dispose();
    _descriptionController.dispose();
    _addressController.dispose();
    _feesController.dispose();
    super.dispose();
  }

  TimeOfDay _timeOfDayFromString(String timeString) {
    if (timeString.isEmpty) {
      print("Warning: Received empty time string. Defaulting to 00:00.");
      // Or throw FormatException("Time string cannot be empty");
      return const TimeOfDay(hour: 0, minute: 0);
    }

    // Handle "TimeOfDay(HH:mm)" format
    if (timeString.startsWith('TimeOfDay(') && timeString.endsWith(')')) {
      final coreTime =
          timeString.substring(10, timeString.length - 1); // "HH:mm"
      final parts = coreTime.split(':');
      if (parts.length == 2) {
        try {
          return TimeOfDay(
              hour: int.parse(parts[0]), minute: int.parse(parts[1]));
        } catch (e) {
          throw FormatException(
              "Invalid time format in TimeOfDay() string: '$timeString'", e);
        }
      }
    }
    // Handle "HH:mm" format
    else {
      final parts = timeString.split(':');
      if (parts.length == 2) {
        try {
          return TimeOfDay(
              hour: int.parse(parts[0]), minute: int.parse(parts[1]));
        } catch (e) {
          throw FormatException(
              "Invalid time format in HH:mm string: '$timeString'", e);
        }
      }
    }
    // If neither format matches or parsing failed
    throw FormatException(
        "Unknown or invalid time string format: '$timeString'");
  }

  Future<void> _pickImage() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStartTime
          ? (_selectedStartTime ?? TimeOfDay.now())
          : (_selectedCloseTime ?? TimeOfDay.now()),
    );
    if (picked != null) {
      setState(() {
        if (isStartTime) {
          _selectedStartTime = picked;
        } else {
          _selectedCloseTime = picked;
        }
      });
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      Get.snackbar("Validation Error", "Please correct the errors in the form.",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (_selectedImage == null &&
        (_uploadedImageUrl == null || _uploadedImageUrl!.isEmpty)) {
      Get.snackbar("Error", "Please select an image for the veterinarian.",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (_selectedStartDay == null ||
        _selectedEndDay == null ||
        _selectedStartTime == null ||
        _selectedCloseTime == null) {
      Get.snackbar("Error", "Please select working days and times.",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    // Optional: Validate that end day/time is after start day/time
    // This can be complex if spanning across midnight or multiple days.
    // For simplicity, this example doesn't include that advanced validation.

    setState(() {
      _isLoading = true;
    });

    String? finalImageUrl = _uploadedImageUrl;
    if (_selectedImage != null) {
      try {
        finalImageUrl = await _uploadService.uploadImage(_selectedImage!);
        if (finalImageUrl == null || finalImageUrl.isEmpty) {
          Get.snackbar("Error", "Image upload failed. Please try again.",
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
    }

    // Prepare time strings for the model (adjust format as needed by your backend/model)
    String? startTimeString = _selectedStartTime != null
        ? '${_selectedStartTime!.hour.toString().padLeft(2, '0')}:${_selectedStartTime!.minute.toString().padLeft(2, '0')}'
        : null;
    String? closeTimeString = _selectedCloseTime != null
        ? '${_selectedCloseTime!.hour.toString().padLeft(2, '0')}:${_selectedCloseTime!.minute.toString().padLeft(2, '0')}'
        : null;

    final vetData = VetDocModel(
      id: widget.vet?.id ?? 0,
      // Let backend assign ID if new (or handle ID generation)
      name: _nameController.text,
      email: _emailController.text,
      specialization: _specializationController.text,
      experienceYears: int.tryParse(_experienceYearsController.text) ?? 0,
      clinicName: _clinicNameController.text,
      startDay: _selectedStartDay,
      endDay: _selectedEndDay,
      startTime: startTimeString,
      // Store as formatted string
      closeTime: closeTimeString,
      // Store as formatted string
      description: _descriptionController.text,
      photoUrl: finalImageUrl,
      address: _addressController.text,
      fees: int.tryParse(_feesController.text) ?? 0,
      reviewScore: widget.vet?.reviewScore ?? 0,
      noOfReviews: widget.vet?.noOfReviews ?? 0,
    );

    try {
      if (widget.vet == null) {
        _vetController.add(vetData); // Assuming add returns Future
        Get.snackbar("Success", "Veterinarian added successfully!",
            snackPosition: SnackPosition.BOTTOM);
      } else {
        _vetController.editVet(vetData); // Assuming updateVet returns Future
        Get.snackbar("Success", "Veterinarian updated successfully!",
            snackPosition: SnackPosition.BOTTOM);
      }
      Get.back(); // Go back to the previous screen
    } catch (e) {
      Get.snackbar("Error", "An error occurred: ${e.toString()}",
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.vet == null ? 'Add Veterinarian' : 'Edit Veterinarian'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: _selectedImage != null
                          ? FileImage(File(_selectedImage!.path))
                          : (_uploadedImageUrl != null &&
                                  _uploadedImageUrl!.isNotEmpty
                              ? NetworkImage(_uploadedImageUrl!)
                              : null) as ImageProvider?,
                      child: (_selectedImage == null &&
                              (_uploadedImageUrl == null ||
                                  _uploadedImageUrl!.isEmpty))
                          ? const Icon(Icons.camera_alt,
                              size: 40, color: Colors.white)
                          : null,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                    child: TextButton.icon(
                        onPressed: _pickImage,
                        icon: const Icon(Icons.image),
                        label: Text(_selectedImage != null ||
                                (_uploadedImageUrl != null &&
                                    _uploadedImageUrl!.isNotEmpty)
                            ? "Change Image"
                            : "Select Image"))),
                const SizedBox(height: 20),

                _buildTextFormField(_nameController, 'Name', isRequired: true),
                _buildTextFormField(_emailController, 'Email',
                    keyboardType: TextInputType.emailAddress, isRequired: true),
                _buildTextFormField(
                    _specializationController, 'Specialization'),
                _buildTextFormField(
                    _experienceYearsController, 'Experience (Years)',
                    keyboardType: TextInputType.number),
                _buildTextFormField(_clinicNameController, 'Clinic Name'),
                _buildTextFormField(
                    _descriptionController, 'Description (Optional)',
                    maxLines: 3),
                _buildTextFormField(
                    _addressController, 'Clinic Address (Optional)'),
                _buildTextFormField(
                    _feesController, 'Consultation Fees (Optional)',
                    keyboardType: TextInputType.number),

                const SizedBox(height: 16),
                const Text("Working Hours:",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),

                // --- Start Day Dropdown ---
                _buildDropdownButtonFormField(
                  value: _selectedStartDay,
                  hint: 'Select Start Day',
                  items: _daysOfWeek,
                  onChanged: (value) {
                    setState(() {
                      _selectedStartDay = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Please select a start day' : null,
                ),
                const SizedBox(height: 10),

                // --- End Day Dropdown ---
                _buildDropdownButtonFormField(
                  value: _selectedEndDay,
                  hint: 'Select End Day',
                  items: _daysOfWeek,
                  onChanged: (value) {
                    setState(() {
                      _selectedEndDay = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Please select an end day' : null,
                ),
                const SizedBox(height: 10),

                // --- Start Time Picker ---
                _buildTimePickerField(
                  context: context,
                  label: 'Select Start Time',
                  selectedTime: _selectedStartTime,
                  onTap: () => _selectTime(context, true),
                  validator: (value) => _selectedStartTime == null
                      ? 'Please select a start time'
                      : null,
                ),
                const SizedBox(height: 10),

                // --- Close Time Picker ---
                _buildTimePickerField(
                  context: context,
                  label: 'Select Close Time',
                  selectedTime: _selectedCloseTime,
                  onTap: () => _selectTime(context, false),
                  validator: (value) => _selectedCloseTime == null
                      ? 'Please select a close time'
                      : null,
                ),
                const SizedBox(height: 30),

                Center(
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: _submitForm,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 15),
                          ),
                          child: Text(widget.vet == null
                              ? 'Add Veterinarian'
                              : 'Update Veterinarian'),
                        ),
                ),
                const SizedBox(height: 20), // For some spacing at the bottom
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper widget for TextFormFields to reduce boilerplate
  Widget _buildTextFormField(
    TextEditingController controller,
    String label, {
    TextInputType keyboardType = TextInputType.text,
    bool isRequired = false,
    int? maxLines = 1,
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
        validator: (value) {
          if (isRequired && (value == null || value.isEmpty)) {
            return '$label is required';
          }
          if (label == 'Email' &&
              value != null &&
              value.isNotEmpty &&
              !GetUtils.isEmail(value)) {
            return 'Please enter a valid email';
          }
          if ((label.toLowerCase().contains('experience') ||
                  label.toLowerCase().contains('fees')) &&
              value != null &&
              value.isNotEmpty &&
              double.tryParse(value) == null) {
            return 'Please enter a valid number';
          }
          return null;
        },
      ),
    );
  }

  // Helper for DropdownButtonFormField
  Widget _buildDropdownButtonFormField({
    required String? value,
    required String hint,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    FormFieldValidator<String>? validator,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: hint,
        border: const OutlineInputBorder(),
      ),
      hint: Text(hint),
      isExpanded: true,
      items: items.map((String day) {
        return DropdownMenuItem<String>(
          value: day,
          child: Text(day),
        );
      }).toList(),
      onChanged: onChanged,
      validator: validator,
    );
  }

  // Helper for Time Picker Fields
  Widget _buildTimePickerField({
    required BuildContext context,
    required String label,
    required TimeOfDay? selectedTime,
    required VoidCallback onTap,
    FormFieldValidator<String>? validator,
  }) {
    return TextFormField(
      readOnly: true,
      controller: TextEditingController(
        // Display formatted time or empty string
        text: selectedTime?.format(context) ?? '',
      ),
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        suffixIcon: const Icon(Icons.access_time),
      ),
      onTap: onTap,
      validator: (value) {
        // Validator for the TextFormField itself (checks if a time has been selected via the picker)
        if (selectedTime == null && validator != null) {
          // Call the passed validator if time is not selected
          return validator(null);
        }
        return null;
      },
    );
  }
}
