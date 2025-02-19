import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/base_breed_controller.dart';
import 'breed_details_screen.dart';
import '../model/base_breed_model.dart';

class BreedListScreen extends StatelessWidget {
  final String category;
  final BaseBreedController controller = BaseBreedController();

  BreedListScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    List<BaseBreed> breeds = controller.getBreeds(category);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          "$category Breeds",
          style: GoogleFonts.fredoka(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
         icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white), // Set arrow color to white
          onPressed: () => Navigator.pop(context),
          ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: breeds.isEmpty
            ? Center(
                child: Text(
                  "No data available, please add breeds.",
                  style: GoogleFonts.fredoka(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              )
            : ListView.builder(
                itemCount: breeds.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(2, 2))
                      ],
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      title: Text(
                        breeds[index].name,
                        style: GoogleFonts.fredoka(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      trailing: Icon(Icons.pets, color: Colors.black54),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BreedDetailsScreen(breed: breeds[index]),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
      ),
     
    );
  }
}
