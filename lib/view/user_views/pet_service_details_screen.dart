import 'dart:developer';

import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care_app/model/pet_services_model.dart';
import 'package:pet_care_app/utils/app_colors.dart';
import 'package:pet_care_app/utils/user_data.dart';
import 'package:pet_care_app/view/appointmentscreen.dart';
import 'package:pet_care_app/view/user_views/book_appointment_screen.dart';
import 'package:pet_care_app/view/user_views/review_screen.dart';

class PetServiceDetailsScreen extends StatefulWidget {
  final PetServicesModel data;
  const PetServiceDetailsScreen({super.key, required this.data});

  @override
  State<PetServiceDetailsScreen> createState() => _PetServiceDetailsScreen();
}

class _PetServiceDetailsScreen extends State<PetServiceDetailsScreen> {
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
                widget.data.photoUrl.isNotEmpty
                    ? widget.data.photoUrl.first
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
              SizedBox(height: 15.h),
              isAdmin ? checkAppointment() : bookAppointment(),
              GestureDetector(
                onTap: () {
                  Get.to(() => ReviewsScreen(
                        id: widget.data.id ?? 0,
                        isService: true,
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
              )
            ],
          ),
        ));
  }

  Widget bookAppointment() {
    return GestureDetector(
      onTap: () {
        Get.to(() => BookAppoinmentScreen(
              services: widget.data,
              servicesAppointment: true,
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
              isService: true,
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
}

//bottom sheet class

class EditServiceBottomSheet extends StatefulWidget {
  final PetServicesModel service;
  final Function(PetServicesModel) onSave;

  const EditServiceBottomSheet({
    super.key,
    required this.service,
    required this.onSave,
  });

  @override
  State<EditServiceBottomSheet> createState() => _EditServiceBottomSheetState();
}

class _EditServiceBottomSheetState extends State<EditServiceBottomSheet> {
  late TextEditingController nameController;
  late TextEditingController descController;
  late TextEditingController feesController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.service.name);
    descController = TextEditingController(text: widget.service.description);
    feesController =
        TextEditingController(text: widget.service.fees.toString());
  }

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    feesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        top: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Edit Service",
              style: GoogleFonts.fredoka(
                  fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: "Service Name"),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: descController,
            decoration: const InputDecoration(labelText: "Description"),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: feesController,
            decoration: const InputDecoration(labelText: "Fees"),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(245, 146, 69, 1)),
            onPressed: () {
              widget.onSave(
                widget.service.copyWith(
                  name: nameController.text,
                  description: descController.text,
                  fees: int.tryParse(feesController.text) ?? 0,
                ),
              );
              Navigator.pop(context);
            },
            child: const Text("Save", style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }
}
