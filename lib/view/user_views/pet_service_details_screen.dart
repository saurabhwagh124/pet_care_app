import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care_app/model/pet_services_model.dart';

class PetServiceDetailsScreen extends StatefulWidget {
  final PetServicesModel data;
  const PetServiceDetailsScreen({super.key, required this.data});

  @override
  State<PetServiceDetailsScreen> createState() => _PetServiceDetailsScreen();
}

class _PetServiceDetailsScreen extends State<PetServiceDetailsScreen> {
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
            titleTextStyle: GoogleFonts.fredoka(
                fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
            backgroundColor: const Color.fromRGBO(248, 174, 31, 1)),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                widget.data.photoUrl.isNotEmpty
                    ? widget.data.photoUrl.first
                    : "https://via.placeholder.com/150",
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 15,
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
                            Text(
                              "${widget.data.category}",
                              style: GoogleFonts.fredoka(
                                fontSize: 17,
                                color: const Color.fromRGBO(6, 78, 87, 1),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              width: 280.w,
                              child: Text(
                                "Description: ${widget.data.description!}",
                                style: GoogleFonts.fredoka(
                                    fontSize: 12, fontWeight: FontWeight.w600),
                              ),
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
                            // Row(
                            //   children: [
                            //     const Icon(
                            //       Icons.access_time,
                            //       size: 12,
                            //     ),
                            //     const SizedBox(width: 8),
                            //     Text(
                            //       "${widget.data.createdAt}",
                            //       style: GoogleFonts.fredoka(
                            //           fontSize: 10,
                            //           color: const Color.fromRGBO(
                            //               166, 166, 166, 1)),
                            //     ),
                            //     const SizedBox(width: 8),
                            //   ],
                            // ),
                            SizedBox(height: 8.h),
                            Text('Fees: ${widget.data.fees} ₹',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ))
                          ]),
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              //   child: Text(
              //     widget.data.description!,
              //     style: GoogleFonts.fredoka(fontSize: 12),
              //   ),
              // ),
              // const Padding(
              //   padding: EdgeInsets.only(left: 20),
              //   child: SizedBox(
              //     width: double.infinity,
              //     child: Text(
              //       'Recommended For: Bella',
              //       style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              //     ),
              //   ),
              // ),
              SizedBox(height: 15),
              GestureDetector(
                onTap: () {},
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
              )
            ],
          ),
        ));
  }
}
