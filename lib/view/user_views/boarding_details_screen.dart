import 'dart:developer';

import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care_app/model/boarding_model.dart';
import 'package:pet_care_app/utils/app_colors.dart';
import 'package:pet_care_app/utils/user_data.dart';
import 'package:pet_care_app/view/appointmentscreen.dart';
import 'package:pet_care_app/view/user_views/book_appointment_screen.dart';
import 'package:pet_care_app/view/user_views/review_screen.dart';
import 'package:pet_care_app/widgets/admin/add_edit_boarding.dart';

import '../../controller/boarding_controller.dart';

class BoardingDetailsScreen extends StatefulWidget {
  final BoardingModel data;

  const BoardingDetailsScreen({super.key, required this.data});

  @override
  State<BoardingDetailsScreen> createState() => _BoardingDetailsScreen();
}

class _BoardingDetailsScreen extends State<BoardingDetailsScreen> {
  final controller = Get.find<BoardingController>();
  bool isAdmin = false;

  @override
  void initState() {
    super.initState();
    isAdmin = UserData().read<bool>("adminEnabled") ?? false;
    log("Admin ENabled? doctor screen" + isAdmin.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 25.sp),
            onPressed: () => Get.back(),
          ),
          backgroundColor: AppColors.yellowCircle,
          title: Text(widget.data.name!),
          centerTitle: true,
          titleTextStyle: GoogleFonts.fredoka(
              fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        body: SingleChildScrollView(
          child: Column(
            spacing: 10.h,
            children: [
              Image.network(
                widget.data.photoUrls.isNotEmpty
                    ? widget.data.photoUrls.first
                    : "https://via.placeholder.com/150",
                fit: BoxFit.cover,
              ),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                height: 175,
                decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.15),
                          offset: Offset(0, 6),
                          blurRadius: 44)
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(26))),
                child: Stack(
                  children: [
                    Text(
                      widget.data.name!,
                      style: GoogleFonts.fredoka(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Positioned(
                      top: 35,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  color: Color.fromRGBO(6, 78, 87, 1),
                                ),
                                Text(
                                  "${widget.data.address}",
                                  style: GoogleFonts.fredoka(
                                    fontSize: 17,
                                    color: const Color.fromRGBO(6, 78, 87, 1),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                RatingBar.readOnly(
                                  size: 20,
                                  halfFilledIcon: Icons.star_half,
                                  halfFilledColor: Colors.amberAccent,
                                  isHalfAllowed: true,
                                  filledIcon: Icons.star,
                                  emptyIcon: Icons.star_border,
                                  initialRating:
                                      widget.data.reviewScore!.toDouble(),
                                  maxRating: 5,
                                  filledColor: Colors.amberAccent,
                                  emptyColor: Colors.grey,
                                ),
                                Text(
                                  "${widget.data.reviewScore} (${widget.data.noOfReviews} reviews)",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  color: Colors.black,
                                  size: 15.sp,
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  "${widget.data.startDay} - ${widget.data.endDay} at ${widget.data.startTime} am - ${widget.data.closeTime} pm",
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Text('Fees: ${widget.data.fees} ₹/day',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    )),
                                SizedBox(
                                  width: 35.w,
                                ),
                                const Icon(
                                  Icons.call,
                                  size: 12,
                                ),
                                Text(' :- ${widget.data.contact}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ],
                            )
                          ]),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.h),
              isAdmin ? checkAppointment() : bookAppointment(),
              GestureDetector(
                onTap: () {
                  Get.to(() => ReviewsScreen(
                        id: widget.data.id ?? 0,
                        isBoarding: true,
                      ));
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(245, 146, 69, 1),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Review Screen",
                        style: GoogleFonts.fredoka(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        width: 35,
                      ),
                      Icon(
                        Icons.reviews,
                        color: Colors.white,
                        size: 20.sp,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              isAdmin
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 30,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Get.off(() => AddEditBoardingScreen(
                                  boarding: widget.data,
                                ));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            "Edit",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            controller.deleteBoarding(widget.data.id ?? 0);
                            Get.back();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            "Delete",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ));
  }

  Widget bookAppointment() {
    return GestureDetector(
      onTap: () {
        Get.to(() => BookAppoinmentScreen(
              boarding: widget.data,
              boardingAppointment: true,
            ));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: const Color.fromRGBO(245, 146, 69, 1),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: [
            const SizedBox(
              width: 90,
            ),
            Text(
              "Book a Service",
              style: GoogleFonts.fredoka(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            const SizedBox(
              width: 80,
            ),
            const ImageIcon(
              AssetImage(
                "assets/images/deadlineIcon.png",
              ),
              color: Colors.white,
              size: 18,
            )
          ],
        ),
      ),
    );
  }

  Widget checkAppointment() {
    return GestureDetector(
      onTap: () {
        Get.to(() => AppointmentsScreen(
              id: widget.data.id ?? 0,
              isBoarding: true,
            ));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 50),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: const Color.fromRGBO(245, 146, 69, 1),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Check Appointments",
              style: GoogleFonts.fredoka(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            const ImageIcon(
              AssetImage(
                "assets/images/deadlineIcon.png",
              ),
              color: Colors.white,
              size: 18,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
