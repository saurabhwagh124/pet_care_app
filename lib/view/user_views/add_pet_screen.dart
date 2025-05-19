import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_care_app/controller/user_pet_controller.dart';
import 'package:pet_care_app/model/user_pet_model.dart';
import 'package:pet_care_app/service/upload_service.dart';
import 'package:pet_care_app/utils/add_pet_vaildator.dart';
import 'package:pet_care_app/utils/app_colors.dart';
import 'package:pet_care_app/widgets/user_pet_widget_icon.dart';

class AddPetsPage extends StatefulWidget {
  const AddPetsPage({super.key});

  @override
  State createState() => _AddPetsPageState();
}

class _AddPetsPageState extends State<AddPetsPage> {
  final userPetController = UserPetController();
  final _formKey = GlobalKey<FormState>();
  final uploadService = UploadService();
  String? photoUrl;
  ValueNotifier<XFile?> image = ValueNotifier<XFile?>(null);
  final _picker = ImagePicker();

  Future<void> _pickImages() async {
    final XFile? pickedFiles =
        await _picker.pickImage(source: ImageSource.gallery);
      image.value = pickedFiles;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
    userPetController.fetchUserPets();
    });
    super.initState();
  }

  // Controllers for bottom sheet input fields
  final TextEditingController petNameController = TextEditingController();
  final TextEditingController speciesController = TextEditingController();
  final TextEditingController breedNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  final TextEditingController genderController =
      TextEditingController(); // New controller
  final TextEditingController heightController =
      TextEditingController(); // New controller
  final TextEditingController weightController = TextEditingController();

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Form(
          key: _formKey,
          child: Container(
            height: 600.h,
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 16.0,
              bottom: 0.0, // Adjust for keyboard
            ),
            child: SingleChildScrollView(
              child: Column(
                spacing: 10.h,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Add New Pet",
                    style: GoogleFonts.fredoka(
                      textStyle: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                  IconButton(
                    onPressed: _pickImages,
                    icon: const Icon(Icons.add_photo_alternate_outlined),
                  ),
                  ValueListenableBuilder(
                    valueListenable: image,
                    builder: (context, value, child) {
                      return (image.value == null)
                          ? const SizedBox.shrink()
                          : SizedBox(
                              width: 100.w,
                              child: Image.file(File(image.value!.path)),
                            );
                    },
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200], // Light grey background
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12, // Light shadow
                          blurRadius: 4, // Slight blur
                          offset: Offset(2, 2), // Shadow position
                        ),
                      ],
                    ),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: petNameController,
                      validator: (value) =>
                          Validation.validateText(value, "Pet Name"),
                      decoration: InputDecoration(
                        labelText: 'Pet Name',
                        labelStyle: GoogleFonts.fredoka(),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none), // Remove inner border
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                      ),
                      style: GoogleFonts.fredoka(),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200], // Light grey background
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12, // Light shadow
                          blurRadius: 4, // Slight blur
                          offset: Offset(2, 2), // Shadow position
                        ),
                      ],
                    ),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: speciesController,
                      validator: (value) =>
                          Validation.validateText(value, "Species"),
                      decoration: InputDecoration(
                        labelText: 'Species ',
                        labelStyle: GoogleFonts.fredoka(),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none), // Remove inner border
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                      ),
                      style: GoogleFonts.fredoka(),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: breedNameController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) =>
                          Validation.validateText(value, "Breed"),
                      decoration: InputDecoration(
                        labelText: 'Breed',
                        labelStyle: GoogleFonts.fredoka(),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                      ),
                      style: GoogleFonts.fredoka(),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200], // Light grey background
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12, // Light shadow
                          blurRadius: 4, // Slight blur
                          offset: Offset(2, 2), // Shadow position
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: descriptionController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) =>
                          Validation.validateText(value, "Pet Description"),
                      decoration: InputDecoration(
                        labelText: 'Pet Description',
                        labelStyle: GoogleFonts.fredoka(),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none), // Remove inner border
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                      ),
                      style: GoogleFonts.fredoka(),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: TextFormField(
                      validator: (value) =>
                          Validation.validateNumber(value, "Age"),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: ageController,
                      decoration: InputDecoration(
                        labelText: 'Age',
                        labelStyle: GoogleFonts.fredoka(),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                      ),
                      style: GoogleFonts.fredoka(),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: heightController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) =>
                          Validation.validateNumber(value, "Height"),
                      decoration: InputDecoration(
                        labelText: 'Height',
                        labelStyle: GoogleFonts.fredoka(),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                      ),
                      style: GoogleFonts.fredoka(),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: weightController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) =>
                          Validation.validateNumber(value, "Weight"),
                      decoration: InputDecoration(
                        labelText: 'Weight',
                        labelStyle: GoogleFonts.fredoka(),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                      ),
                      style: GoogleFonts.fredoka(),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (image.value != null) {
                          photoUrl = await uploadService.uploadImage(image.value!);
                          addPet();
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Please add an image of the pet')),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      fixedSize: const Size.fromWidth(500),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                    ),
                    child: Text(
                      'Add Pet',
                      style: GoogleFonts.fredoka(
                        color: Colors.white, // White text color
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).viewInsets.bottom,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 25.sp),
          onPressed: () => Get.back(),
        ),
        backgroundColor: AppColors.yellowCircle,
        centerTitle: true,
        title: Text(
          'Add Pets',
          style: GoogleFonts.fredoka(
            textStyle: const TextStyle(
                fontSize: 23, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
      ),
      body: RefreshIndicator(
        color: Colors.green,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Obx(() => Align(
                  alignment: Alignment.centerLeft, // Ensures left alignment
                  child: (userPetController.userPetList.isEmpty)
                      ? Text('No Pets Added',
                          style: GoogleFonts.fredoka(
                            textStyle: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.w600),
                          ))
                      : Text('Added Pets',
                          style: GoogleFonts.fredoka(
                            textStyle: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.w600),
                          )))),
            ),
            Expanded(
                child: Obx(() {
                  final length = userPetController.userPetList.length;
                  final list = userPetController.userPetList;
                  return GridView.builder(
                      padding: EdgeInsets.all(10.sp),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200.w,
                          mainAxisSpacing: 20.h,
                          crossAxisSpacing: 20.w,
                          mainAxisExtent: 200.h),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) =>
                          UserPetWidgetIcon(
                            data: list[index],
                          ),
                      itemCount: length);
                }
    )
    ),
          ],
        ),
        onRefresh: ()async{userPetController.fetchUserPets();},
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[300],
        onPressed: _showBottomSheet,
        child: const Icon(
          Icons.add,
          color: Colors.orange,
        ),
      ),
    );
  }

  void addPet() {
    final user = FirebaseAuth.instance.currentUser!;
    userPetController.addUserPet(UserPetModel(
        id: 0,
        name: petNameController.text.trim(),
        species: speciesController.text.trim(),
        breed: breedNameController.text.trim(),
        description: descriptionController.text.trim(),
        age: double.tryParse(ageController.text.trim()),
        height: double.tryParse(heightController.text.trim()),
        weight: double.tryParse(weightController.text.trim()),
        photoUrl: photoUrl,
        ownerEmail: user.email));
  }
}
