import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'breed_list_screen.dart';

class CategoryScreen extends StatelessWidget {
  final List<Map<String, String>> categories = [
    {'name': 'Dog', 'image': 'assets/images/cate_dog.jpg'},
    {'name': 'Cat', 'image': 'assets/images/cate_cat.jpg'},
    {'name': 'Bird', 'image': 'assets/images/cate_bird.jpg'},
    {'name': 'Aquatic', 'image': 'assets/images/cate_fish.jpg'},
    {'name': 'Others', 'image': 'assets/images/cate_rab.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar
      (
        title: Text(
          "Pet Categories",
          style: GoogleFonts.fredoka(fontWeight: FontWeight.w700, fontSize: 22, color: Colors.white),
        ),
        backgroundColor: Color(0xFFFFA726),
        elevation: 0,
          leading: IconButton(
         icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white), // Set arrow color to white
          onPressed: () => Navigator.pop(context),
          ),
      ),
    
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BreedListScreen(category: categories[index]['name']!),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                        child: Image.asset(
                          categories[index]['image']!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        categories[index]['name']!,
                        style: GoogleFonts.fredoka(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
