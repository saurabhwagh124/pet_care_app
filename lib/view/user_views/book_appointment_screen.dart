import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care_app/controller/appointment_controller.dart';
import 'package:pet_care_app/controller/user_pet_controller.dart';
import 'package:pet_care_app/model/boarding_model.dart';
import 'package:pet_care_app/model/pet_services_model.dart';
import 'package:pet_care_app/model/user_pet_model.dart';
import 'package:pet_care_app/model/vet_doc_model.dart';
import 'package:pet_care_app/utils/app_colors.dart';

class BookAppoinmentScreen extends StatefulWidget {
  final VetDocModel? doctor;
  final PetServicesModel? services;
  final BoardingModel? boarding;
  final bool doctorAppointment;
  final bool servicesAppointment;
  final bool boardingAppointment;

  const BookAppoinmentScreen(
      {super.key,
      this.doctor,
      this.services,
      this.boarding,
      this.doctorAppointment = false,
      this.servicesAppointment = false,
      this.boardingAppointment = false});

  @override
  State<BookAppoinmentScreen> createState() => _BookAppoinmentScreenState();
}

class _BookAppoinmentScreenState extends State<BookAppoinmentScreen> {
  UserPetController userPetController = UserPetController();
  AppointmentController appointmentController = Get.find();
  DateTime today = DateTime.now();
  DateTime selectedDate = DateTime.now();
  String selectedTime = '11:30';
  String selectedPet = "Select Pet";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchTimeSlots();
      userPetController.fetchUserPets();
      if (userPetController.userPetList.isNotEmpty) {
        selectedPet = userPetController.userPetList.first.name!;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime firstDate = DateTime(today.year, today.month, today.day);
    DateTime lastDate = firstDate.add(const Duration(days: 15));
    if (selectedDate.isBefore(firstDate)) {
      selectedDate = firstDate;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 25.sp),
          onPressed: () => Get.back(),
        ),
        backgroundColor: AppColors.yellowCircle,
        title: const Text('Book Appointment'),
        centerTitle: true,
        titleTextStyle: GoogleFonts.fredoka(
            fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Choose a Date',
                style: GoogleFonts.fredoka(
                    fontSize: 24, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              CalendarDatePicker(
                initialDate: selectedDate,
                currentDate: selectedDate,
                firstDate: firstDate,
                lastDate: lastDate,
                onDateChanged: (date) {
                  setState(() {
                    selectedDate = date;
                    fetchTimeSlots();
                  });
                },
              ),
              SizedBox(height: 20.h),
              Text(
                'Pick a Time',
                style: GoogleFonts.fredoka(
                    fontSize: 24, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              Wrap(
                // spacing: 50,
                runSpacing: 15,
                children: [
                  _buildTimeButton('09:30'),
                  _buildTimeButton('10:30'),
                  _buildTimeButton('11:30'),
                  _buildTimeButton('15:30'),
                  _buildTimeButton('16:30'),
                  _buildTimeButton('17:30'),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                'Select Pet',
                style: GoogleFonts.fredoka(
                    fontSize: 24, fontWeight: FontWeight.w500),
              ),
              Obx(() {
                return DropdownButtonFormField<String>(
                  alignment: Alignment.center,
                  menuMaxHeight: 200.h,
                  autovalidateMode: AutovalidateMode.always,
                  validator: (value) {
                    if (value == "Select Pet") {
                      return "Please select a pet";
                    }
                    return null;
                  },
                  itemHeight: 50.h,
                  value: selectedPet.isEmpty ? null : selectedPet,
                  elevation: 8,
                  icon: Icon(
                    Icons.arrow_drop_down_circle,
                    size: 30.sp,
                  ),
                  iconSize: 50.sp,
                  items: [
                    DropdownMenuItem<String>(
                      value: "Select Pet",
                      child: SizedBox(
                        height: 40.h,
                        width: 200.w,
                        child: const ListTile(
                            title: Text("Select Pet",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 30))),
                      ),
                    ),
                    ...userPetController.userPetList.map((pet) {
                      return DropdownMenuItem<String>(
                        value: pet.name,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(5.r)),
                          height: 40.h,
                          width: 200.w,
                          child: ListTile(
                            title: Text(pet.name!),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(pet.photoUrl!),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedPet = value!;
                    });
                  },
                );
              }),
              GestureDetector(
                onTap: () {
                  // Check if userPetController.userPetList is not empty and selectedPet is valid
                  if (userPetController.userPetList.isNotEmpty &&
                      selectedPet != "Select Pet") {
                    try {
                      log("selected pet = $selectedPet");
                      UserPetModel pet = userPetController.userPetList
                          .firstWhere((element) => element.name == selectedPet);
                      if (widget.boardingAppointment) {
                        appointmentController.bookBoardingAppointment(
                            widget.boarding!, pet, selectedDate, selectedTime);
                        log("working if");
                      } else if (widget.servicesAppointment) {
                        appointmentController.bookServiceAppointment(
                            widget.services!, pet, selectedDate, selectedTime);
                        log("working else if");
                      } else {
                        appointmentController.bookDoctorAppointment(
                            widget.doctor!, pet, selectedDate, selectedTime);
                        log("working else");
                      }
                    } catch (e) {
                      log("Error booking appointment: ${e.toString()}");
                      Get.snackbar("Error", "Please select a valid pet.",
                          backgroundColor: Colors.redAccent);
                    }
                  } else {
                    Get.snackbar("Error", "Please select a pet.",
                        backgroundColor: Colors.redAccent);
                  }
                  Get.back();
                },
                child: Container(
                  margin: EdgeInsets.only(top: 20.h),
                  padding: EdgeInsets.all(10.sp),
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(245, 146, 69, 1),
                      borderRadius: BorderRadius.circular(5.r)),
                  child: Row(
                    children: [
                      SizedBox(width: 75.w),
                      Text(
                        "Book an Appointment",
                        style: GoogleFonts.fredoka(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      SizedBox(width: 35.w),
                      const ImageIcon(
                        AssetImage("assets/images/deadlineIcon.png"),
                        color: Colors.white,
                        size: 18,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 200.h,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeButton(String time) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTime = time;
        });
      },
      child: Obx(
        () => (appointmentController.bookedTimeSlots
                .any((slot) => slot.contains(time)))
            ? const SizedBox.shrink()
            : Container(
                margin: EdgeInsets.only(right: 20.w),
                width: 100.w,
                height: 30.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: selectedTime == time ? Colors.orange : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                        offset: Offset(0, 4),
                        blurRadius: 4),
                  ],
                ),
                child: Text(
                  time,
                  style: GoogleFonts.openSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color:
                          selectedTime == time ? Colors.white : Colors.black),
                ),
              ),
      ),
    );
  }

  void fetchTimeSlots() {
    if (widget.doctorAppointment) {
      appointmentController.fetchBookedDoctorTimeSlots(widget.doctor!.id ?? 0,
          "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}");
      log(appointmentController.bookedTimeSlots.toString());
    } else if (widget.servicesAppointment) {
      appointmentController.fetchBookedServiceTimeSlots(
          widget.services!.id ?? 0,
          "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}");
      log(appointmentController.bookedTimeSlots.toString());
    } else {
      appointmentController.fetchBookedBoardingTimeSlots(
          widget.boarding!.id ?? 0,
          "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}");
      log(appointmentController.bookedTimeSlots.toString());
    }
  }
}
