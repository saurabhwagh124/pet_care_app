import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care_app/model/boarding_model.dart';
import 'package:pet_care_app/view/user_views/book_appointment_screen.dart';
import 'package:pet_care_app/view/user_views/review_screen.dart';

class BoardingDetailsScreen extends StatefulWidget {
  final BoardingModel data;
  const BoardingDetailsScreen({super.key, required this.data});

  @override
  State<BoardingDetailsScreen> createState() => _BoardingDetailsScreen();
}

class _BoardingDetailsScreen extends State<BoardingDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: Colors.white,
                )),
            title: Text(widget.data.name!),
            centerTitle: true,
            titleTextStyle: GoogleFonts.fredoka(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
            backgroundColor: const Color.fromRGBO(248, 174, 31, 1)),
        body: SingleChildScrollView(
          child: Column(
            spacing: 10.h,
            children: [
              Image.network(
                widget.data.photoUrls.isNotEmpty ? widget.data.photoUrls.first : "https://via.placeholder.com/150",
                fit: BoxFit.cover,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                height: 175,
                decoration: const BoxDecoration(
                    boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.15), offset: Offset(0, 6), blurRadius: 44)], color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(26))),
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
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                              initialRating: widget.data.reviewScore!.toDouble(),
                              maxRating: 5,
                              filledColor: Colors.amberAccent,
                              emptyColor: Colors.grey,
                            ),
                            Text(
                              "${widget.data.reviewScore} (${widget.data.noOfReviews} reviews)",
                              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
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
              GestureDetector(
                onTap: () {
                  Get.to(() => BookAppoinmentScreen(
                        boarding: widget.data,
                        boardingAppointment: true,
                      ));
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: const Color.fromRGBO(245, 146, 69, 1), borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 90,
                      ),
                      Text(
                        "Book a Service",
                        style: GoogleFonts.fredoka(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white),
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
              ),
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
                  decoration: BoxDecoration(color: const Color.fromRGBO(245, 146, 69, 1), borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Review Screen",
                        style: GoogleFonts.fredoka(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white),
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
              )
            ],
          ),
        ));
  }
}
