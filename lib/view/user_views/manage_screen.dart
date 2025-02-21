import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class ManageScreen extends StatelessWidget {
  const ManageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0XFFF8AE1F),
        title: Text(
          'Manage',
          style: GoogleFonts.fredoka(
            textStyle: const TextStyle(fontSize: 23, fontWeight: FontWeight.w600, color: Colors.white),
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
      body: const Center(
        child: Text("Manage Screen"),
      ),
    );
  }
}
