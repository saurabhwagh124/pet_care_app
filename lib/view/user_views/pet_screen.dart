import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care_app/model/user_pet_model.dart';
import 'package:pet_care_app/view/user_views/pethealthscreen.dart';
import 'package:pet_care_app/view/user_views/shop_food_screen.dart';

class Petscreen extends StatelessWidget {
  final UserPetModel data;
  const Petscreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          automaticallyImplyLeading: true,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(children: [
          Container(
            height: 300.h,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(data.photoUrl ?? ""), fit: BoxFit.contain),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 60.w,
              vertical: 16.h,
            ),
            decoration: BoxDecoration(
              boxShadow: const [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.15), offset: Offset(1, 5.47), blurRadius: 43.78)],
              color: const Color.fromRGBO(255, 255, 255, 0.4),
              borderRadius: BorderRadius.circular(27.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  data.name ?? "",
                  style: GoogleFonts.fredoka(
                    textStyle: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  data.breed ?? "",
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
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(
                  children: [
                    const ImageIcon(AssetImage("assets/images/pawIcon.png")),
                    SizedBox(width: 8.w),
                    Text(
                      'About Pomy',
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
            age: "${data.age} yrs",
            weight: '${data.weight}kg',
            height: '${data.height}cm',
            color: 'Black',
            description: data.description.toString(),
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
                      "Pomy's Status",
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
        ])));
  }
}

class PetInfoCard extends StatelessWidget {
  final String age;
  final String weight;
  final String height;
  final String color;
  final String description;

  const PetInfoCard({
    super.key,
    required this.age,
    required this.weight,
    required this.height,
    required this.color,
    required this.description,
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
                _buildInfoChip(age, 'Age'),
                _buildInfoChip(weight, 'Weight'),
                _buildInfoChip(
                  height,
                  'Height',
                ),
                _buildInfoChip(
                  color,
                  'Color',
                ),
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
      decoration:
          BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: const [BoxShadow(color: Color.fromRGBO(79, 144, 166, 1), offset: Offset(0, 2), blurRadius: 1)]),
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
            style: const TextStyle(fontSize: 14, color: Color.fromRGBO(6, 78, 87, 1)),
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
      {super.key, required this.title, required this.subtitle, required this.description, required this.buttonText, required this.buttonColor, required this.icon, required this.onPressed});

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
