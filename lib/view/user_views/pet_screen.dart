import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_care_app/controller/user_pet_controller.dart';
import 'package:pet_care_app/model/user_pet_model.dart';
import 'package:pet_care_app/service/upload_service.dart';
import 'package:pet_care_app/utils/app_colors.dart';
import 'package:pet_care_app/view/user_views/pethealthscreen.dart';
import 'package:pet_care_app/view/user_views/shop_food_screen.dart';

class Petscreen extends StatefulWidget {
  final UserPetModel data;
  const Petscreen({super.key, required this.data});

  @override
  State<Petscreen> createState() => _PetscreenState();
}

class _PetscreenState extends State<Petscreen> {
  UserPetController userPetController = UserPetController();
  bool _isEditing = false;
  String? photoUrl;
  XFile? imageFile;
  final _picker = ImagePicker();
  late TextEditingController _nameController;
  late TextEditingController _breedController;
  late TextEditingController _ageController;
  late TextEditingController _weightController;
  late TextEditingController _heightController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.data.name);
    _breedController = TextEditingController(text: widget.data.breed);
    _ageController = TextEditingController(text: widget.data.age?.toString());
    _weightController =
        TextEditingController(text: widget.data.weight?.toString());
    _heightController =
        TextEditingController(text: widget.data.height?.toString());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _breedController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  Future<void> _pickImages() async {
    final XFile? pickedFiles =
        await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile = pickedFiles;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 25.sp),
            onPressed: () => Get.back(),
          ),
          backgroundColor: AppColors.yellowCircle,
          centerTitle: true,
          title: Text(
            widget.data.name ?? "",
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600),
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(children: [
          Stack(children: [
            Container(
              height: 300.h,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: (imageFile != null)
                        ? FileImage(File(imageFile!.path))
                        : NetworkImage(widget.data.photoUrl ?? ""),
                    fit: BoxFit.contain),
              ),
            ),
            (_isEditing)
                ? Positioned(
                    bottom: 10,
                    right: 0,
                    child: GestureDetector(
                      onTap: _pickImages,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.r),
                            border: Border.all(color: Colors.lightBlueAccent)),
                        child: Row(
                          spacing: 10.w,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text("edit Image"),
                            Icon(Icons.edit_outlined)
                          ],
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink()
          ]),
          SizedBox(
            height: 10.h,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 60.w,
              vertical: 16.h,
            ),
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.15),
                    offset: Offset(1, 5.47),
                    blurRadius: 43.78)
              ],
              color: const Color.fromRGBO(255, 255, 255, 0.4),
              borderRadius: BorderRadius.circular(27.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _isEditing
                    ? SizedBox(
                        width: 80.w,
                        height: 25.h,
                        child: TextField(
                          textAlign: TextAlign.center,
                          textAlignVertical: TextAlignVertical.bottom,
                          controller: _nameController,
                          decoration: const InputDecoration(
                            hintText: "Pet Name",
                          ),
                        ),
                      )
                    : Text(
                        widget.data.name ?? "",
                        style: GoogleFonts.fredoka(
                          textStyle: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ),
                const SizedBox(height: 4),
                _isEditing
                    ? SizedBox(
                        width: 80.w,
                        height: 25.h,
                        child: TextField(
                          textAlign: TextAlign.center,
                          textAlignVertical: TextAlignVertical.bottom,
                          controller: _breedController,
                          decoration: const InputDecoration(
                            hintText: "Breed",
                          ),
                        ),
                      )
                    : Text(
                        widget.data.breed ?? "",
                        style: GoogleFonts.fredoka(
                          textStyle: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromRGBO(6, 78, 87, 1),
                          ),
                        ),
                      ),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          // Pet Info Card
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const ImageIcon(
                            AssetImage("assets/images/pawIcon.png")),
                        SizedBox(width: 8.w),
                        Text(
                          'About ${widget.data.name}',
                          style: GoogleFonts.fredoka(
                            textStyle: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ])),
          PetInfoCard(
            age: "${widget.data.age} yrs",
            weight: '${widget.data.weight}kg',
            height: '${widget.data.height}cm',
            description: widget.data.description.toString(),
            isEditing: _isEditing,
            ageController: _ageController,
            weightController: _weightController,
            heightController: _heightController,
          ),

          // Pet Status Section
          Padding(
            padding: EdgeInsets.all(8.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const ImageIcon(AssetImage("assets/images/statusIcon.png")),
                    const SizedBox(width: 8),
                    Text(
                      "${widget.data.name}'s Status",
                      style: GoogleFonts.fredoka(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                PetStatusCard(
                    icon: Icons.favorite,
                    title: 'Health',
                    subtitle: 'Abnormal',
                    description: 'Last Vaccinated (2mon Ago)',
                    buttonText: 'Contact Vet',
                    buttonColor: Colors.redAccent,
                    onPressed: () {
                      Get.to(() => const PetHealth());
                    }),
                const SizedBox(height: 12),
                PetStatusCard(
                  icon: Icons.restaurant,
                  title: 'Food',
                  subtitle: 'Hungry',
                  description: 'Last Fed (4h Ago)',
                  buttonText: 'Check food',
                  buttonColor: Colors.purple,
                  onPressed: () {
                    Get.to(() => const ShopFood());
                  },
                ),
                const SizedBox(height: 12),
                PetStatusCard(
                    icon: Icons.mood,
                    title: 'Mood',
                    subtitle: 'Abnormal',
                    description: 'Seems restless',
                    buttonText: 'Whistle',
                    buttonColor: Colors.blue,
                    onPressed: () {
                      Get.to(() => const PetHealth());
                    }),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    if (_isEditing) {
                      if (imageFile != null) {
                        UploadService service = UploadService();
                        photoUrl = await service.uploadImage(imageFile!);
                      }
                      updatePet(UserPetModel(
                          id: widget.data.id,
                          name: _nameController.text.trim(),
                          species: widget.data.species,
                          breed: _breedController.text.trim(),
                          description: widget.data.description,
                          age: double.tryParse(_ageController.text.trim()),
                          height:
                              double.tryParse(_heightController.text.trim()),
                          weight:
                              double.tryParse(_weightController.text.trim()),
                          photoUrl: photoUrl ?? widget.data.photoUrl,
                          ownerEmail: widget.data.ownerEmail));
                    }
                    setState(() {
                      _isEditing = !_isEditing;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: _isEditing ? Colors.green : Colors.blue,
                  ),
                  child: Text(
                    _isEditing ? "Save" : "Edit",
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Delete",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          )
        ])));
  }

  void updatePet(UserPetModel pet) async {
    UserPetModel temp = await userPetController.editUserPet(pet);
    Get.off(() => Petscreen(data: temp));
  }
}

class PetInfoCard extends StatelessWidget {
  final String age;
  final String weight;
  final String height;
  final String description;
  final bool isEditing;
  final TextEditingController ageController;
  final TextEditingController weightController;
  final TextEditingController heightController;

  const PetInfoCard({
    super.key,
    required this.age,
    required this.weight,
    required this.height,
    required this.description,
    required this.isEditing,
    required this.ageController,
    required this.weightController,
    required this.heightController,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: false,
      margin: const EdgeInsets.all(16),
      elevation: 2,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                isEditing
                    ? Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromRGBO(79, 144, 166, 1),
                                  offset: Offset(0, 2),
                                  blurRadius: 1)
                            ]),
                        child: Column(
                          children: [
                            const Text(
                              "Age",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 45.w,
                              height: 20.h,
                              child: TextField(
                                cursorHeight: 18,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                controller: ageController,
                                decoration: const InputDecoration(),
                              ),
                            )
                          ],
                        ),
                      )
                    : _buildInfoChip(age, 'Age'),
                isEditing
                    ? Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromRGBO(79, 144, 166, 1),
                                  offset: Offset(0, 2),
                                  blurRadius: 1)
                            ]),
                        child: Column(
                          children: [
                            const Text(
                              "Weight",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 45.w,
                              height: 20.h,
                              child: TextField(
                                cursorHeight: 18,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                controller: weightController,
                                decoration: const InputDecoration(),
                              ),
                            )
                          ],
                        ),
                      )
                    : _buildInfoChip(weight, 'Weight'),
                isEditing
                    ? Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromRGBO(79, 144, 166, 1),
                                  offset: Offset(0, 2),
                                  blurRadius: 1)
                            ]),
                        child: Column(
                          children: [
                            const Text(
                              "Height",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 45.w,
                              height: 20.h,
                              child: TextField(
                                cursorHeight: 18,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                controller: heightController,
                                decoration: const InputDecoration(),
                              ),
                            )
                          ],
                        ),
                      )
                    : _buildInfoChip(
                        height,
                        'Height',
                      ),
                // _buildInfoChip(
                //   color,
                //   'Color',
                // ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              description,
              style: const TextStyle(
                fontSize: 14,
                color: Color.fromRGBO(6, 0, 0, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
                color: Color.fromRGBO(79, 144, 166, 1),
                offset: Offset(0, 2),
                blurRadius: 1)
          ]),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
                fontSize: 14, color: Color.fromRGBO(6, 78, 87, 1)),
          ),
        ],
      ),
    );
  }
}

class PetStatusCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final String buttonText;
  final Color buttonColor;
  final IconData icon;
  final VoidCallback onPressed;

  const PetStatusCard(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.description,
      required this.buttonText,
      required this.buttonColor,
      required this.icon,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      borderOnForeground: false,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: buttonColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: buttonColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                buttonText,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// text field
