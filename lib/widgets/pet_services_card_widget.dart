import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/model/pet_services_model.dart';
import 'package:pet_care_app/view/user_views/pet_service_details_screen.dart';

class PetServicesCardWidget extends StatefulWidget {
  final PetServicesModel data;
  const PetServicesCardWidget({
    required this.data,
    super.key,
  });

  @override
  State<PetServicesCardWidget> createState() => _PetServicesCardWidgetState();
}

class _PetServicesCardWidgetState extends State<PetServicesCardWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => PetServiceDetailsScreen(
              data: widget.data,
            ));
      },
      child: Container(
        height: 131.h,
        margin: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  blurRadius: 4,
                  offset: Offset(0, 4))
            ],
            border: Border.all(),
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.r)),
        child: Padding(
          padding: EdgeInsets.all(10.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      widget.data.photoUrl.first,
                      width: 60.w,
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.data.name ?? "",
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Wrap(
                          children: [
                            RatingBar.readOnly(
                              halfFilledIcon: Icons.star_half,
                              halfFilledColor: Colors.amberAccent,
                              isHalfAllowed: true,
                              filledIcon: Icons.star,
                              emptyIcon: Icons.star_border,
                              initialRating: widget.data.reviewScore ?? 0.0,
                              maxRating: 5,
                              filledColor: Colors.amberAccent,
                              emptyColor: Colors.grey,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              '${widget.data.reviewScore} (${widget.data.noOfReviews} reviews)',
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    widget.data.open! ? 'OPEN' : 'CLOSED',
                    style: TextStyle(
                      color: widget.data.open! ? Colors.green : Colors.red,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // const Spacer(),
                  // Icon(Icons.location_pin, size: 15.sp, color: Colors.black),
                  // SizedBox(width: 4.w),
                  // Text(
                  //   '${widget.data.distance} km',
                  //   style: TextStyle(fontSize: 12.sp, color: Colors.black),
                  // ),
                  const Spacer(),
                  Icon(
                    Icons.currency_rupee_outlined,
                    color: Colors.black,
                    size: 15.sp,
                  ),
                  Text("${widget.data.fees}",
                      style: TextStyle(fontSize: 12.sp, color: Colors.black)),
                ],
              ),
              const SizedBox(height: 8),
              // Row(
              //   children: [
              //     Icon(Icons.access_time, size: 15.sp, color: Colors.black),
              //     SizedBox(width: 4.w),
              //      Text(
              //       "${widget.data.} - ${data.endDay} at ${data.startTime} - ${data.closeTime}",
              //       style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12.sp, color: Colors.black),
              //     )
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
