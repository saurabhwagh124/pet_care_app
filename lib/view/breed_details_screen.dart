import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/base_breed_model.dart';

class BreedDetailsScreen extends StatelessWidget {
  final BaseBreed breed;

  BreedDetailsScreen({required this.breed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFA726),
        title: Text(
          breed.name,
          style: GoogleFonts.fredoka(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded,
              color: Colors.white), // Set arrow color to white
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display Breed Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                breed.imageUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    color: Colors.grey.shade300,
                    child: Icon(Icons.image_not_supported,
                        size: 100, color: Colors.grey),
                  );
                },
              ),
            ),
            SizedBox(height: 16),

            // Details Section
            _buildDetailTile(
                "Size & Lifespan", "${breed.size} | ${breed.lifespan}"),
            _buildDetailTile("Temperament", breed.temperament),
            _buildDetailTile("Health Issues", breed.healthIssues),
            _buildDetailTile("Grooming Needs", breed.groomingNeeds),
            _buildDetailTile("Diet & Nutrition", breed.dietNutrition),
            _buildDetailTile(
                "Exercise Requirements", breed.exerciseRequirements),
            _buildDetailTile(
                "Trainability & Intelligence", breed.trainabilityIntelligence),
            _buildDetailTile("Climate Suitability", breed.climateSuitability),
            _buildDetailTile("Space Needs", breed.apartmentSpaceNeeds),
            _buildDetailTile("Purpose & Suitability", breed.purposeSuitability),
            _buildDetailTile("Adoption vs. Buying", breed.adoptionBuying),
          ],
        ),
      ),
    );
  }

  // Custom Styled Detail Tile
  Widget _buildDetailTile(String title, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(2, 2))
        ],
      ),
      child: RichText(
        text: TextSpan(
          style: GoogleFonts.fredoka(fontSize: 16, color: Colors.black87),
          children: [
            TextSpan(
                text: "$title: ",
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}
