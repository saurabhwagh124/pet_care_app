// import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care_app/controller/review_controller.dart';
import 'package:pet_care_app/model/user.dart';
import 'package:pet_care_app/utils/user_data.dart';

class AddReviewPage extends StatefulWidget {
  final int id;
  final bool isDoctor;
  final bool isBoarding;
  final bool isService;
  final bool isItem;
  const AddReviewPage({super.key, required this.id, this.isDoctor = false, this.isBoarding = false, this.isService = false, this.isItem = false});

  @override
  State<AddReviewPage> createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  double _rating = 0.0;
  final TextEditingController _reviewController = TextEditingController();
  final UserData _userData = UserData();
  User? user;

  @override
  void initState() {
    final response = jsonDecode(_userData.read<String>("user")!);
    user = User.fromJson(response);
    log("user data fetched: ${user.toString()}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8AE1F),
        title: Text(
          'Add Review',
          style: GoogleFonts.fredoka(
            textStyle: const TextStyle(fontSize: 23, fontWeight: FontWeight.w600, color: Colors.white),
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
        padding: EdgeInsets.all(10.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25.r,
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(user!.photoUrl!),
                ),
                SizedBox(width: 16.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user!.displayName!,
                      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 24.h),
            Text('Rate your experience',
                style: GoogleFonts.fredoka(
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                )),
            SizedBox(height: 8.h),
            RatingBar.builder(
              initialRating: _rating,
              minRating: 0,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 35.sp,
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
            SizedBox(height: 24.h),
            Text(
              'Share more about your experience',
              style: GoogleFonts.fredoka(
                textStyle: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _reviewController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Share details of your own experience at this place',
                border: OutlineInputBorder(),
              ),
            ),
            const Spacer(),
            Center(
              child: SizedBox(
                width: 200.w,
                child: ElevatedButton(
                  onPressed: _submitReview,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                    backgroundColor: Colors.orange,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                  ),
                  child: Text('Post Review',
                      style: GoogleFonts.fredoka(
                        textStyle: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, color: Colors.white),
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitReview() {
    if (_reviewController.text.isNotEmpty) {
      final reviewController = ReviewController();
      if (widget.isDoctor) {
        reviewController.addDoctorReview(widget.id,user!, _reviewController.text, _rating);
      } else if (widget.isBoarding) {
        reviewController.addBoardingReview(widget.id,user!,  _reviewController.text,_rating);
      } else if (widget.isService) {
        reviewController.addServiceReview(widget.id, user!, _reviewController.text,_rating);
      } else if (widget.isItem) {
        reviewController.addItemReview(widget.id,user!, _reviewController.text, _rating);
      }
      Get.back();
    } else {
      Get.snackbar(
        'Empty Review',
        'Please write a review before submitting',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      
    }
  }
}
