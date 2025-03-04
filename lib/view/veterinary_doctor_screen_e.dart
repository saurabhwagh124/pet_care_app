import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care_app/model/vet_doc_model.dart';
import 'package:pet_care_app/view/user_views/review_screen.dart';

class VeterinaryDoctorAdmin extends StatefulWidget {
  final VetDocModel data;
  const VeterinaryDoctorAdmin({super.key, required this.data});

  @override
  State<VeterinaryDoctorAdmin> createState() => _VeterinaryDoctorState();
}

class _VeterinaryDoctorState extends State<VeterinaryDoctorAdmin> {
  bool _isEditing = false;
  late TextEditingController _nameController;
  late TextEditingController _specializationController;
  late TextEditingController _descriptionController;
  late TextEditingController _feesController;
  late TextEditingController _startDayController;
  late TextEditingController _endDayController;
  late TextEditingController _startTimeController;
  late TextEditingController _closeTimeController;
  late TextEditingController _emailController;
  late TextEditingController _experienceYearsController;
  late TextEditingController _addressController;
  late TextEditingController _clinicNameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.data.name);
    _specializationController =
        TextEditingController(text: widget.data.specialization);
    _descriptionController =
        TextEditingController(text: widget.data.description);
    _feesController = TextEditingController(text: widget.data.fees.toString());
    _startDayController = TextEditingController(text: widget.data.startDay);
    _endDayController = TextEditingController(text: widget.data.endDay);
    _startTimeController = TextEditingController(text: widget.data.startTime);
    _closeTimeController = TextEditingController(text: widget.data.closeTime);
    _emailController = TextEditingController(text: widget.data.email);
    _experienceYearsController =
        TextEditingController(text: widget.data.experienceYears.toString());
    _addressController = TextEditingController(text: widget.data.address);
    _clinicNameController = TextEditingController(text: widget.data.clinicName);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _specializationController.dispose();
    _descriptionController.dispose();
    _feesController.dispose();
    _startDayController.dispose();
    _endDayController.dispose();
    _startTimeController.dispose();
    _closeTimeController.dispose();
    _emailController.dispose();
    _experienceYearsController.dispose();
    _addressController.dispose();
    _clinicNameController.dispose();
    super.dispose();
  }

  void updateVet(VetDocModel vet) {
    // Implement the logic to update the vet data
    // For example, you might call an API or update a local database
    // After updating, you can navigate back or refresh the screen
  }

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
          ),
        ),
        title: Text(widget.data.name!),
        centerTitle: true,
        titleTextStyle: GoogleFonts.fredoka(
            fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
        backgroundColor: const Color.fromRGBO(248, 174, 31, 1),
        actions: [
          if (!_isEditing)
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.white),
              onPressed: () {
                setState(() {
                  _isEditing = true;
                });
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(widget.data.photoUrl!),
            SizedBox(height: 15.h),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 275.h,
              decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.15),
                        offset: Offset(0, 6),
                        blurRadius: 44)
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(26))),
              child: Wrap(
                children: [
                  _isEditing
                      ? TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(hintText: "Name"),
                          style: GoogleFonts.fredoka(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )
                      : Text(
                          widget.data.name!,
                          style: GoogleFonts.fredoka(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                  SizedBox(height: 28.h),
                  _isEditing
                      ? TextField(
                          controller: _specializationController,
                          decoration:
                              const InputDecoration(hintText: "Specialization"),
                          style: GoogleFonts.fredoka(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        )
                      : Text(
                          widget.data.specialization!,
                          style: GoogleFonts.fredoka(
                            fontSize: 17,
                            color: const Color.fromRGBO(6, 78, 87, 1),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                  SizedBox(height: 28.h),
                  !_isEditing
                      ? Row(
                          children: [
                            RatingBar.readOnly(
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
                              style: TextStyle(
                                  fontSize: 14.sp, fontWeight: FontWeight.w500),
                            ),
                          ],
                        )
                      : SizedBox.shrink(),
                  SizedBox(height: 30.h),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 16,
                      ),
                      SizedBox(width: 10.w),
                      _isEditing
                          ? Expanded(
                              child: TextFormField(
                                controller: _startDayController,
                                decoration:
                                    const InputDecoration(hintText: "Start Day"),
                                style: GoogleFonts.fredoka(
                                  fontSize: 10,
                                  color: const Color.fromRGBO(166, 166, 166, 1),
                                ),
                                readOnly: true, // Make the field read-only
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2101),
                                  );
                                  if (pickedDate != null) {
                                    String formattedDate =
                                        "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                                    setState(() {
                                      _startDayController.text = formattedDate;
                                    });
                                  }
                                },
                              ),
                            )
                          : Text(
                              widget.data.startDay!,
                              style: GoogleFonts.fredoka(
                                fontSize: 15,
                                color: const Color.fromRGBO(166, 166, 166, 1),
                              ),
                            ),
                      SizedBox(width: 10.w),
                      _isEditing
                          ? Expanded(
                              child: TextFormField(
                                controller: _endDayController,
                                decoration:
                                    const InputDecoration(hintText: "End Day"),
                                style: GoogleFonts.fredoka(
                                  fontSize: 10,
                                  color: const Color.fromRGBO(166, 166, 166, 1),
                                ),
                                readOnly: true, // Make the field read-only
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2101),
                                  );
                                  if (pickedDate != null) {
                                    String formattedDate =
                                        "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                                    setState(() {
                                      _endDayController.text = formattedDate;
                                    });
                                  }
                                },
                              ),
                            )
                          : Text(
                              widget.data.endDay!,
                              style: GoogleFonts.fredoka(
                                fontSize: 15,
                                color: const Color.fromRGBO(166, 166, 166, 1),
                              ),
                            ),
                      SizedBox(width: 10.w),
                      _isEditing
                          ? Expanded(
                              child: TextFormField(
                                controller: _startTimeController,
                                decoration:
                                    const InputDecoration(hintText: "Start Time"),
                                style: GoogleFonts.fredoka(
                                  fontSize: 10,
                                  color: const Color.fromRGBO(166, 166, 166, 1),
                                ),
                                readOnly: true, // Make the field read-only
                                onTap: () async {
                                  TimeOfDay? pickedTime = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );
                                  if (pickedTime != null) {
                                    String formattedTime =
                                        "${pickedTime.hour}:${pickedTime.minute}";
                                    setState(() {
                                      _startTimeController.text = formattedTime;
                                    });
                                  }
                                },
                              ),
                            )
                          : Text(
                              widget.data.startTime!,
                              style: GoogleFonts.fredoka(
                                fontSize: 15,
                                color: const Color.fromRGBO(166, 166, 166, 1),
                              ),
                            ),
                      SizedBox(width: 10.w),
                      _isEditing
                          ? Expanded(
                              child: TextFormField(
                                controller: _closeTimeController,
                                decoration:
                                    const InputDecoration(hintText: "Close Time"),
                                style: GoogleFonts.fredoka(
                                  fontSize: 10,
                                  color: const Color.fromRGBO(166, 166, 166, 1),
                                ),
                                readOnly: true, // Make the field read-only
                                onTap: () async {
                                  TimeOfDay? pickedTime = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );
                                  if (pickedTime != null) {
                                    String formattedTime =
                                        "${pickedTime.hour}:${pickedTime.minute}";
                                    setState(() {
                                      _closeTimeController.text = formattedTime;
                                    });
                                  }
                                },
                              ),
                            )
                          : Text(
                              widget.data.closeTime!,
                              style: GoogleFonts.fredoka(
                                fontSize: 15,
                                color: const Color.fromRGBO(166, 166, 166, 1),
                              ),
                            ),
                    ],
                  ),
                  SizedBox(height: 25.h),
                  _isEditing
                      ? TextField(
                          controller: _feesController,
                          decoration: const InputDecoration(hintText: "Fees"),
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          keyboardType: TextInputType.number,
                        )
                      : Text(
                          '${widget.data.fees} ₹ for an Appointment',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                  SizedBox(height: 25.h),
                  _isEditing
                      ? TextField(
                          controller: _descriptionController,
                          decoration:
                              const InputDecoration(hintText: "Description"),
                          style: GoogleFonts.fredoka(fontSize: 16),
                          maxLines: 3,
                        )
                      : Text(
                          widget.data.description!,
                          style: GoogleFonts.fredoka(fontSize: 16),
                        ),
                  SizedBox(height: 25.h),
                ],
              ),
            ),
            SizedBox(height: 20.h),
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
                    SizedBox(width: 35.w),
                    Icon(
                      Icons.reviews,
                      color: Colors.white,
                      size: 20.sp,
                    )
                  ],
                ),
              ),
            ),
            if (_isEditing)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: ElevatedButton(
                  onPressed: () {
                    updateVet(VetDocModel(
                      id: widget.data.id,
                      name: _nameController.text.trim(),
                      specialization: _specializationController.text.trim(),
                      description: _descriptionController.text.trim(),
                      fees: int.tryParse(_feesController.text.trim()) ??
                          widget.data.fees,
                      photoUrl: widget.data.photoUrl,
                      reviewScore: widget.data.reviewScore,
                      noOfReviews: widget.data.noOfReviews,
                      startDay: _startDayController.text.trim(),
                      endDay: _endDayController.text.trim(),
                      startTime: _startTimeController.text.trim(),
                      closeTime: _closeTimeController.text.trim(),
                      email: _emailController.text.trim(),
                      experienceYears: int.tryParse(
                              _experienceYearsController.text.trim()) ??
                          widget.data.experienceYears,
                      address: _addressController.text.trim(),
                      clinicName: _clinicNameController.text.trim(),
                    ));
                    setState(() {
                      _isEditing = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text("Save",
                      style: GoogleFonts.fredoka(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white)),
                ),
              ),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }
}