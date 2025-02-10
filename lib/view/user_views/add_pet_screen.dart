import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care_app/controller/user_pet_controller.dart';

class AddPetsPage extends StatefulWidget {
  const AddPetsPage({super.key});

  @override
  _AddPetsPageState createState() => _AddPetsPageState();
}

class _AddPetsPageState extends State<AddPetsPage> {
  final userPetController = UserPetController();

  @override
  void initState() {
    userPetController.fetchUserPets();
    super.initState();
  }

  // Controllers for bottom sheet input fields
  final TextEditingController petNameController = TextEditingController();
  final TextEditingController breedNameController = TextEditingController();
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
        return Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 16.0,
            bottom:
                MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Add New Pet",
                  style: GoogleFonts.fredoka(
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 16),
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
                  child: TextField(
                    controller: petNameController,
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
                const SizedBox(height: 16),
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
                  child: TextField(
                    controller: breedNameController,
                    decoration: InputDecoration(
                      labelText: 'Breed',
                      labelStyle: GoogleFonts.fredoka(),
                      border:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                    ),
                    style: GoogleFonts.fredoka(),
                  ),
                ),
                const SizedBox(height: 16),
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
                  child: TextField(
                    controller: ageController,
                    decoration: InputDecoration(
                      labelText: 'Age',
                      labelStyle: GoogleFonts.fredoka(),
                      border:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                    ),
                    style: GoogleFonts.fredoka(),
                  ),
                ),
                const SizedBox(height: 16),
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
                  child: TextField(
                    controller: colorController,
                    decoration: InputDecoration(
                      labelText: 'Color',
                      labelStyle: GoogleFonts.fredoka(),
                      border:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                    ),
                    style: GoogleFonts.fredoka(),
                  ),
                ),
                const SizedBox(height: 16),
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
                  child: TextField(
                    controller: genderController,
                    decoration: InputDecoration(
                      labelText: 'Gender',
                      labelStyle: GoogleFonts.fredoka(),
                      border:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                    ),
                    style: GoogleFonts.fredoka(),
                  ),
                ),
                const SizedBox(height: 16),
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
                  child: TextField(
                    controller: heightController,
                    decoration: InputDecoration(
                      labelText: 'Height',
                      labelStyle: GoogleFonts.fredoka(),
                      border:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                    ),
                    style: GoogleFonts.fredoka(),
                  ),
                ),
                const SizedBox(height: 16),
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
                  child: TextField(
                    controller: weightController,
                    decoration: InputDecoration(
                      labelText: 'Weight',
                      labelStyle: GoogleFonts.fredoka(),
                      border:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                    ),
                    style: GoogleFonts.fredoka(),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (petNameController.text.isNotEmpty &&
                        breedNameController.text.isNotEmpty &&
                        ageController.text.isNotEmpty) {
                      setState(() {
                        // addedPets.add({
                        //   "name": petNameController.text,
                        //   "image": "assets/images/logo.png"
                        // });
                      });
                      petNameController.clear();
                      breedNameController.clear();
                      ageController.clear();
                      colorController.clear();
                      genderController.clear(); // Clear new controller
                      heightController.clear(); // Clear new controller
                      weightController.clear();
                      Get.back();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                                Text('Please fill in all required fields.')),
                      );
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
                )
              ],
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
        centerTitle: true,
        backgroundColor: const Color(0XFFF8AE1F),
        title: Text(
          'Add Pets',
          style: GoogleFonts.fredoka(
            textStyle: const TextStyle(
                fontSize: 23, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
                alignment: Alignment.centerLeft, // Ensures left alignment
                child: Text('Added Pets',
                    style: GoogleFonts.fredoka(
                      textStyle: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ))),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: userPetController.userPetList.length,
              itemBuilder: (context, index) {
                final pet = userPetController.userPetList[index];
                return SizedBox(
                    height: 70, // Adjust the height of the individual card
                    child: Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 64, vertical: 8),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.1,
                          backgroundColor: null,
                          child: Image.network(
                            pet.photoUrl ?? "",
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          pet.name ?? "",
                          style: GoogleFonts.fredoka(
                              textStyle: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight
                                      .w500)), // Apply Fredoka to the title
                        ),
                      ),
                    ));
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[300],
        onPressed: _showBottomSheet,
        child: const Icon(Icons.add),
      ),
    );
  }
}
