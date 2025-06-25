import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care_app/controller/base_breed_controller.dart';
import 'package:pet_care_app/model/base_breed_model.dart';
import 'package:pet_care_app/utils/app_colors.dart';
import 'breed_details_screen.dart';

class BreedListScreen extends StatelessWidget {
  final String category;
  final BaseBreedController controller = BaseBreedController();

  BreedListScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    List<BaseBreed> breeds = controller.getBreeds(category);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 25.sp),
          onPressed: () => Get.back(),
        ),
        backgroundColor: AppColors.yellowCircle,
        title: Text(
          "$category Breeds",
          style: GoogleFonts.fredoka(
              fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: breeds.isEmpty
            ? Center(
                child: Text(
                  "No data available, please add breeds.",
                  style: GoogleFonts.fredoka(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              )
            : ListView.builder(
                itemCount: breeds.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(2, 2))
                      ],
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      title: Text(
                        breeds[index].name,
                        style: GoogleFonts.fredoka(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      trailing: const Icon(Icons.pets, color: Colors.black54),
                      onTap: () {
                        Get.to(
                          () => BreedDetailsScreen(breed: breeds[index]),
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
