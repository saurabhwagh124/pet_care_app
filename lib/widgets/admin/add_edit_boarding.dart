import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart'; // <<< Ensure this is imported
import 'package:pet_care_app/controller/boarding_controller.dart';
import 'package:pet_care_app/model/boarding_model.dart';
import 'package:pet_care_app/service/upload_service.dart';
import 'package:pet_care_app/utils/add_pet_vaildator.dart'; // Assuming this is your validator

class AddEditBoardingScreen extends StatefulWidget {
  final BoardingModel? boarding;

  const AddEditBoardingScreen({super.key, this.boarding});

  @override
  State<AddEditBoardingScreen> createState() => _AddEditBoardingScreenState();
}

class _AddEditBoardingScreenState extends State<AddEditBoardingScreen> {
  final _boardingController = Get.find<BoardingController>();
  final _uploadService = UploadService();
  final _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _contactController;
  late TextEditingController _addressController;
  late TextEditingController _feesController;

  List<dynamic> _imageSources = []; // Can be XFile or String (URL)
  bool _isLoading = false;

  String? _selectedStartDay;
  String? _selectedEndDay;
  TimeOfDay? _selectedStartTime;
  TimeOfDay? _selectedCloseTime;

  final List<String> _daysOfWeek = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.boarding?.name ?? '');
    _emailController =
        TextEditingController(text: widget.boarding?.email ?? '');
    _contactController =
        TextEditingController(text: widget.boarding?.contact ?? '');
    _addressController =
        TextEditingController(text: widget.boarding?.address ?? '');
    _feesController =
        TextEditingController(text: widget.boarding?.fees?.toString() ?? '');

    if (widget.boarding != null) {
      if (widget.boarding!.photoUrls.isNotEmpty) {
        _imageSources = List.from(widget.boarding!.photoUrls);
      }
      _selectedStartDay = widget.boarding!.startDay;
      _selectedEndDay = widget.boarding!.endDay;

      // Robust time parsing
      if (widget.boarding!.startTime != null &&
          widget.boarding!.startTime!.isNotEmpty) {
        _selectedStartTime = _timeOfDayFromString(widget.boarding!.startTime!);
      }
      if (widget.boarding!.closeTime != null &&
          widget.boarding!.closeTime!.isNotEmpty) {
        _selectedCloseTime = _timeOfDayFromString(widget.boarding!.closeTime!);
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

  // --- Robust Time Parsing ---
  TimeOfDay _timeOfDayFromString(String timeString) {
    if (timeString.isEmpty) {
      print(
          "Warning: Received empty time string for TimeOfDay conversion. Defaulting to 00:00.");
      return const TimeOfDay(hour: 0, minute: 0);
    }

    try {
      DateTime parsedDateTime;
      // Try "h:mm a" (e.g., 9:30 AM, 10:00 PM)
      try {
        parsedDateTime = DateFormat('h:mm a').parseLoose(timeString);
        return TimeOfDay.fromDateTime(parsedDateTime);
      } catch (e) {
        // Try "HH:mm" (e.g., 09:30, 22:00)
        try {
          parsedDateTime = DateFormat('HH:mm').parseLoose(timeString);
          return TimeOfDay.fromDateTime(parsedDateTime);
        } catch (e2) {
          // Try "TimeOfDay(HH:mm)" format if others fail
          if (timeString.startsWith('TimeOfDay(') && timeString.endsWith(')')) {
            final coreTime =
                timeString.substring(10, timeString.length - 1); // "HH:mm"
            parsedDateTime = DateFormat('HH:mm').parseLoose(coreTime);
            return TimeOfDay.fromDateTime(parsedDateTime);
          }
          print(
              "Error: Could not parse time string: '$timeString'. Attempted formats: 'h:mm a', 'HH:mm', 'TimeOfDay(HH:mm)'. Errors: $e, $e2");
          return const TimeOfDay(hour: 0, minute: 0); // Fallback
        }
      }
    } catch (e) {
      print("Error in _timeOfDayFromString for input '$timeString': $e");
      return const TimeOfDay(hour: 0, minute: 0); // Fallback
    }
  }

  // --- Format TimeOfDay to String (HH:mm) for storage ---
  String _formatTimeOfDay(TimeOfDay? tod) {
    if (tod == null) return '';
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    return DateFormat('HH:mm')
        .format(dt); // Consistent 24-hour format for storage
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _contactController.dispose();
    _addressController.dispose();
    _feesController.dispose();
    super.dispose();
  }

  Future<void> _pickImages() async {
    final List<XFile> pickedFiles =
        await _picker.pickMultiImage(imageQuality: 70);
    if (pickedFiles.isNotEmpty) {
      setState(() {
        // Add new XFiles to the list of sources
        _imageSources.addAll(pickedFiles);
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _imageSources.removeAt(index);
    });
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
    if (_selectedStartDay == null || _selectedEndDay == null) {
      Get.snackbar("Validation Error", "Please select operating days.",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (_selectedStartTime == null || _selectedCloseTime == null) {
      Get.snackbar("Validation Error", "Please select operating times.",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (_imageSources.isEmpty) {
      Get.snackbar(
          "Error", "Please select at least one image for the boarding service.",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    List<String> finalImageUrls = [];
    List<XFile> newImagesToUpload = [];

    // Separate existing URLs from new XFiles
    for (var source in _imageSources) {
      if (source is XFile) {
        newImagesToUpload.add(source);
      } else if (source is String) {
        finalImageUrls.add(source); // This is an existing URL
      }
    }

    if (newImagesToUpload.isNotEmpty) {
      try {
        final uploadedUrls =
            await _uploadService.uploadMultipleFiles(newImagesToUpload);
        finalImageUrls.addAll(uploadedUrls); // Add newly uploaded URLs
      } catch (e) {
        Get.snackbar("Error", "Image upload failed: ${e.toString()}",
            snackPosition: SnackPosition.BOTTOM);
        setState(() {
          _isLoading = false;
        });
        return;
      }
    }

    // Basic check if all selected sources ended up as URLs
    int totalInitialSources = _imageSources.length;
    if (finalImageUrls.length != totalInitialSources) {
      // This check might be too simplistic if some initial URLs were meant to be kept
      // and some new images failed to upload.
      // A more robust check would be to see if the number of XFiles matches newly added URLs.
      print(
          "Warning: Number of final URLs (${finalImageUrls.length}) does not match total initial sources (${totalInitialSources}). Some images might have failed to upload or were duplicates.");
      // Consider if a stronger error message is needed if newImagesToUpload.isNotEmpty and its count doesn't match the new URLs
    }

    final boardingData = BoardingModel(
      id: widget.boarding?.id ?? 0,
      // Ensure ID is a string
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      contact: _contactController.text.trim(),
      address: _addressController.text.trim().isNotEmpty
          ? _addressController.text.trim()
          : null,
      fees: int.tryParse(_feesController.text.trim()) ?? 0,
      startDay: _selectedStartDay,
      endDay: _selectedEndDay,
      reviewScore: widget.boarding?.reviewScore ?? 0.0,
      noOfReviews: widget.boarding?.noOfReviews ?? 0,
      startTime: _formatTimeOfDay(_selectedStartTime),
      // Use formatted string
      closeTime: _formatTimeOfDay(_selectedCloseTime),
      // Use formatted string
      photoUrls: finalImageUrls,
      // Use the consolidated list of URLs
      createdAt: widget.boarding?.createdAt,
    );

    try {
      if (widget.boarding == null) {
        _boardingController
            .addBoarding(boardingData); // Make sure this returns a Future
      } else {
        _boardingController
            .updateBoarding(boardingData); // Make sure this returns a Future
      }
      // Go back to the previous screen
    } catch (e) {
      Get.snackbar("Error", "Operation failed: ${e.toString()}",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.red);
    } finally {
      setState(() {
        _isLoading = false;
      });
      Get.back(canPop: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.boarding == null
            ? 'Add Boarding Service'
            : 'Edit Boarding Service'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTextFormField(_nameController, "Name",
                    validator: (v) => Validation.validateText(v, "Name")),
                _buildTextFormField(_emailController, "Email",
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) => Validation.validateEmail(v)),
                _buildTextFormField(_contactController, "Contact",
                    keyboardType: TextInputType.phone,
                    validator: (v) => Validation.validateNumber(v, "Contact")),
                _buildTextFormField(_addressController, "Address (Optional)"),
                _buildTextFormField(_feesController, "Fees",
                    keyboardType: TextInputType.number,
                    validator: (v) => Validation.validateNumber(v, "Fee")),
                SizedBox(height: 16.h),
                Text("Operating Days",
                    style: Theme.of(context).textTheme.titleMedium),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Expanded(
                      child: _buildDropdownFormField(
                        label: "Start Day",
                        value: _selectedStartDay,
                        items: _daysOfWeek,
                        onChanged: (value) =>
                            setState(() => _selectedStartDay = value),
                        validator: (value) =>
                            value == null ? 'Select start day' : null,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: _buildDropdownFormField(
                        label: "End Day",
                        value: _selectedEndDay,
                        items: _daysOfWeek,
                        onChanged: (value) =>
                            setState(() => _selectedEndDay = value),
                        validator: (value) =>
                            value == null ? 'Select end day' : null,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Text("Operating Hours",
                    style: Theme.of(context).textTheme.titleMedium),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Expanded(
                      child: _buildTimePickerField(
                        context: context,
                        label: "Open Time",
                        selectedTime: _selectedStartTime,
                        onTap: () => _selectTime(context, true),
                        validator: (time) =>
                            time == null ? 'Select open time' : null,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: _buildTimePickerField(
                        context: context,
                        label: "Close Time",
                        selectedTime: _selectedCloseTime,
                        onTap: () => _selectTime(context, false),
                        validator: (time) =>
                            time == null ? 'Select close time' : null,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                Text("Boarding Images:",
                    style: TextStyle(
                        fontSize: 16.sp, fontWeight: FontWeight.bold)),
                SizedBox(height: 8.h),
                ElevatedButton.icon(
                  onPressed: _pickImages,
                  icon: const Icon(Icons.add_photo_alternate_outlined),
                  label: const Text("Select Images"),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 40.h)),
                ),
                SizedBox(height: 10.h),
                _buildImagePreview(),
                SizedBox(height: 30.h),
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 50.w, vertical: 15.h),
                          textStyle: TextStyle(fontSize: 16.sp),
                        ),
                        child: Text(widget.boarding == null
                            ? 'Add Boarding'
                            : 'Update Boarding'),
                      ),
                SizedBox(height: 20.h),
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
    String? Function(String?)? validator,
    int? maxLines = 1,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        ),
        validator: validator,
      ),
    );
  }

  Widget _buildDropdownFormField({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w, vertical: 4.h), // Adjusted padding
        ),
        value: value,
        isExpanded: true,
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item, style: TextStyle(fontSize: 14.sp)),
          );
        }).toList(),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }

  Widget _buildTimePickerField({
    required BuildContext context,
    required String label,
    required TimeOfDay? selectedTime,
    required VoidCallback onTap,
    String? Function(TimeOfDay?)? validator, // Added validator for TimeOfDay
  }) {
    // For the validator to work with the Form, this field needs to be part of the Form.
    // A simple way is to wrap it with a FormField.
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: FormField<TimeOfDay>(
        initialValue: selectedTime, // Set initial value for FormField state
        validator: validator,
        builder: (FormFieldState<TimeOfDay> field) {
          return InkWell(
            onTap: () async {
              final TimeOfDay? picked = await showTimePicker(
                context: context,
                initialTime: selectedTime ?? TimeOfDay.now(),
              );
              if (picked != null) {
                // Call the original onTap to update the state variable
                // and then update the FormField's state
                onTap(); // This will call the setState in _selectTime
                field.didChange(picked); // Update FormField state
              }
            },
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: label,
                border: const OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                errorText: field.errorText, // Display validation error
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    // Use field.value to reflect the FormField's current state
                    field.value != null
                        ? field.value!.format(context)
                        : 'Select Time',
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: field.value != null
                            ? null
                            : Theme.of(context).hintColor),
                  ),
                  const Icon(Icons.arrow_drop_down, color: Colors.grey),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildImagePreview() {
    if (_imageSources.isEmpty) {
      return Center(
          child: Text("No images selected.",
              style: TextStyle(color: Colors.grey, fontSize: 14.sp)));
    }
    return Wrap(
      spacing: 10.w,
      runSpacing: 10.h,
      children: List.generate(_imageSources.length, (index) {
        final imageSource = _imageSources[index];
        ImageProvider imageProvider;
        bool isFileImage = false;

        if (imageSource is XFile) {
          imageProvider = FileImage(File(imageSource.path));
          isFileImage = true;
        } else if (imageSource is String && imageSource.isNotEmpty) {
          if (Uri.tryParse(imageSource)?.isAbsolute ?? false) {
            imageProvider = NetworkImage(imageSource);
          } else {
            // Potentially a local file path string (less ideal, XFile is better)
            // This case should ideally not happen if new images are always XFiles
            print(
                "Warning: Image source is a string but not a valid URL: $imageSource. Attempting as FileImage.");
            try {
              imageProvider = FileImage(File(imageSource));
              isFileImage = true;
            } catch (e) {
              print("Error creating FileImage from string: $e");
              return Container(
                  width: 100.w,
                  height: 100.h,
                  color: Colors.red[100],
                  child: const Icon(Icons.error_outline, color: Colors.red));
            }
          }
        } else {
          return Container(
              width: 100.w,
              height: 100.h,
              color: Colors.grey[300],
              child: const Icon(Icons.broken_image));
        }

        return Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              width: 100.w,
              height: 100.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                  onError: (exception, stackTrace) {
                    print("Error loading image ($imageSource): $exception");
                    // If it's a file image that failed, we might not need to setState
                    // If it's a network image, you might want to show a placeholder
                    if (mounted && !isFileImage) {
                      // Only try to rebuild if it was a network image that failed
                      setState(() {
                        // Potentially replace _imageSources[index] with a placeholder indicator
                        // or remove it if it's consistently failing.
                        // For now, just printing the error.
                      });
                    }
                  },
                ),
              ),
            ),
            Positioned(
              right: -5.w,
              top: -5.h,
              child: InkWell(
                onTap: () => _removeImage(index),
                child: Container(
                  padding: EdgeInsets.all(2.r),
                  decoration: const BoxDecoration(
                    color: Colors.redAccent,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.close, color: Colors.white, size: 18.sp),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
