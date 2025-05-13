import 'dart:developer';

import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care_app/model/vet_doc_model.dart';
import 'package:pet_care_app/utils/app_colors.dart';
import 'package:pet_care_app/utils/user_data.dart';
import 'package:pet_care_app/view/appointmentscreen.dart';
import 'package:pet_care_app/view/user_views/book_appointment_screen.dart';
import 'package:pet_care_app/view/user_views/review_screen.dart';

class VeterinaryDoctor extends StatefulWidget {
  final VetDocModel data;
  const VeterinaryDoctor({super.key, required this.data});

  @override
  State<VeterinaryDoctor> createState() => _VeterinaryDoctorState();
}

class _VeterinaryDoctorState extends State<VeterinaryDoctor> {
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
              Image.network(widget.data.photoUrl!),
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
                              widget.data.specialization!,
                              style: GoogleFonts.fredoka(
                                fontSize: 17,
                                color: const Color.fromRGBO(6, 78, 87, 1),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                RatingBar.readOnly(
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
                                const Icon(
                                  Icons.access_time,
                                  size: 12,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '${widget.data.startDay} - ${widget.data.endDay} at ${widget.data.startTime} am - ${widget.data.closeTime} pm',
                                  style: GoogleFonts.fredoka(
                                      fontSize: 10,
                                      color: const Color.fromRGBO(
                                          166, 166, 166, 1)),
                                ),
                                const SizedBox(width: 8),
                                // Row(
                                //   children: [
                                //     const Icon(
                                //       Icons.location_on_outlined,
                                //       size: 10,
                                //     ),
                                //     const SizedBox(width: 5),
                                //     Text(
                                //       '2.5 km',
                                //       style: GoogleFonts.fredoka(textStyle: const TextStyle(fontSize: 11, color: Color.fromRGBO(166, 166, 166, 1))),
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text('${widget.data.fees} ₹ for an Appointment',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ))
                          ]),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text(
                  widget.data.description!,
                  style: GoogleFonts.fredoka(fontSize: 16),
                ),
              ),
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
              const SizedBox(height: 10),

              isAdmin ? checkAppointment() : bookAppointment(),
              GestureDetector(
                onTap: () {
                  Get.to(() => ReviewsScreen(
                        id: widget.data.id ?? 0,
                        isDoctor: true,
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
              doctor: widget.data,
              doctorAppointment: true,
            ));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 50),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: const Color.fromRGBO(245, 146, 69, 1),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            Text(
              "Book an Appointment",
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

  Widget checkAppointment() {
    return GestureDetector(
      onTap: () {
        Get.to(() => AppointmentsScreen(
              id: widget.data.id ?? 0,
              isDoctor: true,
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

// bottom sheet

  void _showEditBottomSheet() {
    final TextEditingController clinicNameController =
        TextEditingController(text: widget.data.clinicName);
    final TextEditingController addressController =
        TextEditingController(text: widget.data.address);
    final TextEditingController feesController =
        TextEditingController(text: widget.data.fees.toString());
    final TextEditingController startDayController =
        TextEditingController(text: widget.data.startDay);
    final TextEditingController endDayController =
        TextEditingController(text: widget.data.endDay);
    final TextEditingController startTimeController =
        TextEditingController(text: widget.data.startTime);
    final TextEditingController closeTimeController =
        TextEditingController(text: widget.data.closeTime);
    final TextEditingController descriptionController =
        TextEditingController(text: widget.data.description);

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text("Edit Doctor Details",
                    style: GoogleFonts.fredoka(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                TextField(
                    controller: clinicNameController,
                    decoration:
                        const InputDecoration(labelText: 'Clinic Name')),
                TextField(
                    controller: addressController,
                    decoration: const InputDecoration(labelText: 'Address')),
                TextField(
                    controller: feesController,
                    decoration: const InputDecoration(labelText: 'Fees'),
                    keyboardType: TextInputType.number),
                TextField(
                    controller: startDayController,
                    decoration: const InputDecoration(labelText: 'Start Day')),
                TextField(
                    controller: endDayController,
                    decoration: const InputDecoration(labelText: 'End Day')),
                TextField(
                    controller: startTimeController,
                    decoration: const InputDecoration(labelText: 'Start Time')),
                TextField(
                    controller: closeTimeController,
                    decoration: const InputDecoration(labelText: 'Close Time')),
                TextField(
                    controller: descriptionController,
                    decoration:
                        const InputDecoration(labelText: 'Description')),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Call your update API or logic here
                    log("Updated Data:");
                    log("Clinic: ${clinicNameController.text}");
                    log("Fees: ${feesController.text}");
                    // Update model or call controller to save
                    Navigator.pop(context);
                  },
                  child: const Text("Save Changes"),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
