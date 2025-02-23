// import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pet_care_app/model/user.dart';
import 'package:pet_care_app/utils/user_data.dart';

class AddReviewPage extends StatefulWidget {
  const AddReviewPage({super.key});

  @override
  State<AddReviewPage> createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  double _rating = 0.0;
  final TextEditingController _reviewController = TextEditingController();
  final UserData _userData = UserData();

  late User _user;

  @override
  void initState() {
    final response = jsonDecode(_userData.read("user"));
    _user = User.fromJson(response);
    log("user data fetched: ${_user.toString()}");
  }

  void _submitReview() {
    if (_rating > 0 && _reviewController.text.isNotEmpty) {
      Get.back(result: {
        'name': 'New User', // Replace with actual user data if available
        'timeAgo': 'Just now',
        'rating': _rating,
        'review': _reviewController.text,
        'avatarUrl': 'https://via.placeholder.com/150',
      });
    } else {
      // Show an error or validation if needed
      print("Please provide a rating and review.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8AE1F),
        title: Text(
          'Add Review',
          style: GoogleFonts.fredoka(
            textStyle: const TextStyle(
                fontSize: 23, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Get.back(); // Custom back button behavior
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(
                    'assets/images/haylie.png',
                  ),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Haylie Aminoff',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text('Rate your experience',
                style: GoogleFonts.fredoka(
                  textStyle: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                )),
            const SizedBox(height: 8),
            RatingBar.builder(
              initialRating: _rating,
              minRating: 0,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 40,
              glow: false,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amberAccent,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  _rating = rating;
                });
              },
            ),
            const SizedBox(height: 24),
            Text(
              'Share more about your experience',
              style: GoogleFonts.fredoka(
                textStyle:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _reviewController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Share details of your own experience at this place',
                border: OutlineInputBorder(),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitReview,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text('Post Review',
                    style: GoogleFonts.fredoka(
                      textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
