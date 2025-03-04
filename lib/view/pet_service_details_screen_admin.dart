import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care_app/model/pet_services_model.dart';
import 'package:pet_care_app/view/user_views/review_screen.dart';

class PetServiceDetailsScreenAdmin extends StatefulWidget {
  final PetServicesModel data;
  const PetServiceDetailsScreenAdmin({super.key, required this.data});

  @override
  State<PetServiceDetailsScreenAdmin> createState() => _PetServiceDetailsScreen();
}

class _PetServiceDetailsScreen extends State<PetServiceDetailsScreenAdmin> {
  bool _isEditing = false;
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _feesController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.data.name);
    _descriptionController = TextEditingController(text: widget.data.description);
    _feesController = TextEditingController(text: widget.data.fees.toString());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _feesController.dispose();
    super.dispose();
  }

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveChanges() {
    // Implement the logic to save changes
    setState(() {
      _isEditing = false;
    });
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
        actions: _isEditing
            ? null
            : [
                IconButton(
                  onPressed: _toggleEditing,
                  icon: const Icon(
                    Icons.edit,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ],
        title: Text(widget.data.name!),
        centerTitle: true,
        titleTextStyle: GoogleFonts.fredoka(
            fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
        backgroundColor: const Color.fromRGBO(248, 174, 31, 1),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              widget.data.photoUrl.isNotEmpty
                  ? widget.data.photoUrl.first
                  : "https://via.placeholder.com/150",
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20,),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 200,
              decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.15),
                        offset: Offset(0, 6),
                        blurRadius: 44)
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(26))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  const SizedBox(height: 8),
                  _isEditing
                      ? TextField(
                          controller: _descriptionController,
                          decoration: const InputDecoration(hintText: "Description"),
                          style: GoogleFonts.fredoka(
                              fontSize: 15, fontWeight: FontWeight.w400),
                          maxLines: null,
                        )
                      : Text(
                          "Description: ${widget.data.description!}",
                          style: GoogleFonts.fredoka(
                              fontSize: 15, fontWeight: FontWeight.w400),
                        ),
                  const SizedBox(height: 8),
                  if (!_isEditing)
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
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  const SizedBox(height: 8),
                  _isEditing
                      ? TextField(
                          controller: _feesController,
                          decoration: const InputDecoration(hintText: "Fees"),
                          style: GoogleFonts.fredoka(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        )
                      : Text('Fees: ${widget.data.fees} ₹',
                           style: GoogleFonts.fredoka(
                              fontSize: 16, fontWeight: FontWeight.w500),),

                      
                ],
              ),
            ),
            SizedBox(height: 15.h),
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
            if (_isEditing)
              Container(width: 70,height: 30,
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                // padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    // const Spacer(),
                    TextButton(
                      onPressed: _saveChanges,
                      child: Text(
                        "Save",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.fredoka(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      
                    )
                  ],
                ),
              ),
            SizedBox(
              height: 50.h,
            )
          ],
        ),
      ),
    );
  }
}