import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddPetsPage extends StatefulWidget {
  const AddPetsPage({super.key});

  @override
  _AddPetsPageState createState() => _AddPetsPageState();
}

class _AddPetsPageState extends State<AddPetsPage> {
  // List to store added pets
  List<Map<String, String>> addedPets = [
    {"name": "Bella", "image": "assets/images/bella.png"},
    {"name": "Roudy", "image": "assets/images/roundy.png"},
    {"name": "Furry", "image": "assets/images/furry.png"},
  ];

  // Controllers for bottom sheet input fields
  final TextEditingController petNameController = TextEditingController();
  final TextEditingController breedNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  final TextEditingController genderController = TextEditingController(); // New controller
  final TextEditingController heightController = TextEditingController(); // New controller
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
            bottom: MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Add New Pet",
                  style: GoogleFonts.fredoka(
                    textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200], // Light grey background
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                    boxShadow: [
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
                      border: OutlineInputBorder(borderSide: BorderSide.none), // Remove inner border
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    style: GoogleFonts.fredoka(),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
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
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    style: GoogleFonts.fredoka(),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
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
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    style: GoogleFonts.fredoka(),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
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
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    style: GoogleFonts.fredoka(),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
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
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    style: GoogleFonts.fredoka(),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
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
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    style: GoogleFonts.fredoka(),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
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
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    style: GoogleFonts.fredoka(),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (petNameController.text.isNotEmpty && breedNameController.text.isNotEmpty && ageController.text.isNotEmpty) {
                      setState(() {
                        addedPets.add({"name": petNameController.text, "image": "assets/images/logo.png"});
                      });
                      petNameController.clear();
                      breedNameController.clear();
                      ageController.clear();
                      colorController.clear();
                      genderController.clear(); // Clear new controller
                      heightController.clear(); // Clear new controller
                      weightController.clear();
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please fill in all required fields.')),
                      );
                    }
                  },
                  child: Text(
                    'Add Pet',
                    style: GoogleFonts.fredoka(
                      color: Colors.white, // White text color
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    fixedSize: Size.fromWidth(500),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                ),
                SizedBox(
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
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          'Add Pets',
          style: GoogleFonts.fredoka(
            textStyle: const TextStyle(fontSize: 23, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Align(
                alignment: Alignment.centerLeft, // Ensures left alignment
                child: Text('Added Pets',
                    style: GoogleFonts.fredoka(
                      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ))),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: addedPets.length,
              itemBuilder: (context, index) {
                final pet = addedPets[index];
                return Container(
                    height: 70, // Adjust the height of the individual card
                    child: Card(
                      margin: EdgeInsets.symmetric(horizontal: 64, vertical: 8),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.1,
                          backgroundColor: null,
                          child: Image.asset(
                            pet["image"]!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          pet["name"]!,
                          style: GoogleFonts.fredoka(textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)), // Apply Fredoka to the title
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
        child: Icon(Icons.add),
      ),
    );
  }
}
