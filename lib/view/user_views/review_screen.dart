import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care_app/controller/review_controller.dart';
import 'package:pet_care_app/model/general_review_model.dart';
import 'package:pet_care_app/utils/enums.dart';
import 'package:pet_care_app/view/user_views/add_review_page.dart';
import 'package:timeago/timeago.dart' as timeago;

class ReviewsScreen extends StatefulWidget {
  final bool isDoctor;
  final bool isBoarding;
  final bool isService;
  final int id;
  const ReviewsScreen({super.key, this.isDoctor = false, this.isBoarding = false, this.isService = false, required this.id});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  final ReviewController reviewController = Get.put(ReviewController());

  @override
  void initState() {
    super.initState();
    if (widget.isDoctor) {
      reviewController.fetchDoctorReviews(widget.id);
    } else if (widget.isBoarding) {
      reviewController.fetchBoardingReviews(widget.id);
    } else if (widget.isService) {
      reviewController.fetchServiceReviews(widget.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8AE1F),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Get.back();
          },
          color: Colors.white,
        ),
        title: Text(
          'Reviews',
          style: GoogleFonts.fredoka(
            textStyle: const TextStyle(fontSize: 23, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Overall Rating Section
          Center(
            child: Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      reviewController.averageRating.value.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RatingBar.readOnly(
                      alignment: Alignment.center,
                      halfFilledIcon: Icons.star_half,
                      halfFilledColor: Colors.amberAccent,
                      isHalfAllowed: true,
                      filledIcon: Icons.star,
                      emptyIcon: Icons.star_border,
                      initialRating: reviewController.averageRating.value,
                      maxRating: 5,
                      filledColor: Colors.amberAccent,
                      emptyColor: Colors.grey,
                      size: 40.sp,
                    ),
                    Text(
                      'Based on ${reviewController.noOfReviews.value} reviews',
                      style: GoogleFonts.fredoka(
                        textStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ),
                  ],
                )),
          ),
          SizedBox(height: 16.h),
          // Individual Reviews
          Obx(() => Expanded(
                child: (reviewController.reviewApiStatus.value == ApiStatus.SUCCESS)
                    ? ListView.builder(itemBuilder: (context, index) => ReviewCard(data: reviewController.reviewsList[index]), itemCount: reviewController.reviewsList.length)
                    : (reviewController.reviewApiStatus.value == ApiStatus.LOADING)
                        ? const Center(child: CircularProgressIndicator())
                        : const Center(child: Text('No Reviews Found!')),
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(() => const AddReviewPage());
        },
        backgroundColor: Colors.orange,
        label: Text(
          "Add Review",
          style: TextStyle(color: Colors.white, fontSize: 14.sp),
        ),
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  final GeneralReviewModel data;

  const ReviewCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 2,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage:
                  data.users!.photoUrl!.isNotEmpty ? NetworkImage(data.users!.photoUrl!) : const NetworkImage('https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png'),
              radius: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.users!.displayName!,
                    style: GoogleFonts.fredoka(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Text(
                    timeago.format(data.createdAt!),
                    style: GoogleFonts.fredoka(
                      textStyle: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                  Wrap(
                    children: [
                      RatingBar.readOnly(
                        halfFilledIcon: Icons.star_half,
                        halfFilledColor: Colors.amberAccent,
                        isHalfAllowed: true,
                        filledIcon: Icons.star,
                        emptyIcon: Icons.star_border,
                        initialRating: data.reviewScore!.toDouble(),
                        maxRating: 5,
                        filledColor: Colors.amberAccent,
                        emptyColor: Colors.grey,
                      ),
                      Text(
                        "${data.reviewScore}",
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    data.reviewDescription ?? "",
                    style: GoogleFonts.fredoka(
                      textStyle: const TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
