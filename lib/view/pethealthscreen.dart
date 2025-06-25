import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care_app/utils/app_colors.dart';
import 'package:pet_care_app/view/user_views/explore_screen.dart';

class PetHealth extends StatefulWidget {
  const PetHealth({super.key});

  @override
  State<PetHealth> createState() => _PetHealthState();
}

class _PetHealthState extends State<PetHealth> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 25.sp),
            onPressed: () => Get.back(),
          ),
          backgroundColor: AppColors.yellowCircle,
          title: const Text(
            'Pet Health',
            style: TextStyle(
                fontSize: 30, color: Colors.white, fontWeight: FontWeight.w500),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Wellness'),
              Tab(text: 'Medical Records'),
            ],
            labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
            indicatorColor: Colors.white,
            indicatorPadding: EdgeInsets.only(bottom: 8),
          ),
        ),
        body: TabBarView(children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Section(
                  title: 'Vaccinations',
                  seeAll: true,
                  children: [
                    Row(
                      children: [
                        VaccinationCard(
                          title: 'Rabies vaccination',
                          date: '24th Sep 2024',
                          doctor: 'Dr. Rafeeqa',
                        ),
                        VaccinationCard(
                          title: 'Calicivirus',
                          date: '12th Feb 2024',
                          doctor: 'Dr. Arham',
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Section(
                  title: 'Allergies',
                  seeAll: true,
                  children: [
                    Row(
                      children: [
                        AllergyCard(
                          title: 'Skin Allergies',
                          description:
                              'May be accompanied by \ngastrointestinal symptoms.',
                          doctor: 'Dr. Irfan',
                        ),
                        AllergyCard(
                          title: 'Food Allergies',
                          description:
                              'Vomiting and diarrhea,\nor dermatologicsigns.',
                          doctor: 'Dr. Imran',
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Section(
                  title: 'Appointments',
                  seeAll: false,
                  children: [
                    Text(
                      'When you schedule an appointment, you’ll see it here. Let’s set your first appointment.',
                      style: GoogleFonts.fredoka(fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(245, 146, 69, 1)),
                        onPressed: () {
                          log("Get not added so won't get to next screen");
                          Get.to(() => ExploreScreen());
                        },
                        child: Text(
                          'Start',
                          style: GoogleFonts.fredoka(
                              color: Colors.white, fontSize: 22),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Section(
                    title: "Past Vaccinations",
                    seeAll: true,
                    children: [
                      Row(
                        children: [
                          VaccinationCard(
                            title: 'Rabies vaccination',
                            date: 'Mon 24 Jan',
                            doctor: 'Dr. Ikram',
                          ),
                          VaccinationCard(
                            title: 'Calicivirus',
                            date: 'Tue 12 Feb',
                            doctor: 'Dr. Rafeeqa',
                          ),
                        ],
                      ),
                    ]),
                const SizedBox(height: 10),
                Section(title: "Past Treatment", seeAll: false, children: [
                  Text(
                    "Allergies",
                    style: GoogleFonts.fredoka(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const Row(
                    children: [
                      TreatmentCard(
                        title: 'Skin Allergies',
                        date: 'Wed 13 Mar',
                        doctor: 'Dr. Maham',
                      ),
                      TreatmentCard(
                        title: 'Food Allergies',
                        date: 'Thu 14 Apr',
                        doctor: 'Dr. Imran',
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Icon(Icons.arrow_forward_ios_outlined)
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    "Cough",
                    style: GoogleFonts.fredoka(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const Row(
                    children: [
                      TreatmentCard(
                        title: 'Kennel Cough',
                        date: 'Wed 15 May',
                        doctor: 'Dr. Imran',
                      ),
                      TreatmentCard(
                        title: 'Canine Cough',
                        date: 'Wed 16 Jun',
                        doctor: 'Dr. Ali',
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Icon(Icons.arrow_forward_ios_outlined)
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: double.maxFinite,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'See all',
                        style: GoogleFonts.fredoka(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromRGBO(59, 115, 143, 1)),
                      ),
                      const Icon(Icons.keyboard_arrow_down_outlined)
                    ],
                  ),
                ])
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class Section extends StatelessWidget {
  final String title;
  final bool seeAll;
  final List<Widget> children;
  const Section(
      {super.key,
      required this.title,
      required this.seeAll,
      required this.children});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: GoogleFonts.fredoka(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                if (seeAll)
                  Row(
                    children: [
                      Text(
                        'See all',
                        style: GoogleFonts.fredoka(
                            color: const Color.fromRGBO(59, 115, 143, 1),
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                        size: 16,
                      ),
                    ],
                  ),
              ],
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }
}

class VaccinationCard extends StatelessWidget {
  final String title;
  final String date;
  final String doctor;
  const VaccinationCard(
      {super.key,
      required this.title,
      required this.date,
      required this.doctor});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.fredoka(
                  fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              date,
              style: GoogleFonts.fredoka(fontSize: 12),
            ),
            const SizedBox(height: 8),
            Text(doctor, style: GoogleFonts.fredoka(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

class AllergyCard extends StatelessWidget {
  final String title;
  final String description;
  final String doctor;
  const AllergyCard(
      {super.key,
      required this.title,
      required this.description,
      required this.doctor});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.fredoka(
                  fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(description, style: GoogleFonts.fredoka(fontSize: 10)),
            const SizedBox(height: 8),
            Text(doctor, style: GoogleFonts.fredoka(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

class TreatmentCard extends StatelessWidget {
  final String title;
  final String date;
  final String doctor;
  const TreatmentCard(
      {super.key,
      required this.title,
      required this.date,
      required this.doctor});
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style:
                GoogleFonts.fredoka(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            date,
            style: GoogleFonts.fredoka(fontSize: 12),
          ),
          const SizedBox(height: 8),
          Text(doctor, style: GoogleFonts.fredoka(fontSize: 12)),
        ],
      ),
    ));
  }
}
