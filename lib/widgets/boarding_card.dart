import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care_app/model/boarding_model.dart';
import 'package:pet_care_app/utils/app_colors.dart';

class BoardingCard extends StatelessWidget {
  final BoardingModel data;
  const BoardingCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.all(20.r),
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(15.r), boxShadow: [BoxShadow(color: Colors.black, blurRadius: 4.r, offset: Offset(0, 1.h))]),
        child: Column(
          children: [
            Row(
              children: [
                //image container column
                Column(
                  children: [
                    SizedBox(
                      height: 40.h,
                      width: 70.w,
                      child: Image.network(data.photoUrls.first),
                    ),
                  ],
                ),
                SizedBox(
                  width: 20.w,
                ),
                //text name & rating column
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.name ?? "",
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.black),
                    ),
                    Wrap(
                      direction: Axis.vertical,
                      children: [
                        RatingBar.readOnly(
                          filledIcon: Icons.star,
                          emptyIcon: Icons.star_border_outlined,
                          filledColor: Colors.amberAccent,
                          emptyColor: Colors.grey,
                          halfFilledIcon: Icons.star_half,
                          halfFilledColor: Colors.amberAccent,
                          isHalfAllowed: true,
                          maxRating: 5,
                          initialRating: data.reviewScore ?? 0.0,
                        ),
                        Text(
                          "${data.reviewScore} {${data.noOfReviews}reviews}",
                          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.black),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
            Row(
              children: [
                // Text(
                //   (data.) ? "Open" : "Closed",
                //   style: TextStyle(
                //       fontSize: 14.sp,
                //       fontWeight: FontWeight.w400,
                //       color: (data.isOpen) ? Colors.green : Colors.red),
                // ),
                // const Spacer(),
                // Icon(
                //   Icons.location_pin,
                //   size: 15.sp,
                //   color: Colors.black,
                // ),
                // Text(
                //   "${data.distance}km",
                //   style: TextStyle(
                //       fontSize: 14.sp,
                //       fontWeight: FontWeight.w400,
                //       color: Colors.black),
                // ),
                SizedBox(
                  width: 10.w,
                ),
                Icon(
                  Icons.currency_rupee_outlined,
                  size: 15.sp,
                  color: Colors.black,
                ),
                Text(
                  "${data.fees}",
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.black),
                )
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  color: Colors.black,
                  size: 15.sp,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  "${data.startDay} - ${data.endDay} at ${data.startTime} - ${data.closeTime}",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12.sp, color: Colors.black),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
