import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care_app/model/vet_doctor_model.dart';
import 'package:pet_care_app/utils/app_colors.dart';
import 'package:pet_care_app/view/veterinary_doctor_screen.dart';

class VetCardWidget extends StatelessWidget {
  final VetDoctorModel data;
  const VetCardWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const VeterinaryDoctor()));
      },
      child: Container(
        margin: EdgeInsets.all(10.r),
        height: 130.h,
        width: 280.w,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(0, 1.h),
              blurRadius: 4.r,
              spreadRadius: 0,
            ),
          ],
        ),
        padding: EdgeInsets.all(10.sp),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    data.profileImg,
                    width: 60.w,
                  ),
                ),
                SizedBox(width: 5.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Dr. ${data.name}",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        data.degree,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.greyTextColor,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Wrap(
                        children: [
                          RatingBar.readOnly(
                            halfFilledIcon: Icons.star_half,
                            halfFilledColor: Colors.amberAccent,
                            isHalfAllowed: true,
                            filledIcon: Icons.star,
                            emptyIcon: Icons.star_border,
                            initialRating: data.reviewStars,
                            maxRating: 5,
                            filledColor: Colors.amberAccent,
                            emptyColor: Colors.grey,
                          ),
                          Text(
                            "${data.reviewStars} (${data.numberOfReview} reviews)",
                            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "${data.yearsOfExp} years of experience",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.greyTextColor,
                            ),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.location_pin,
                            color: AppColors.greyTextColor,
                            size: 10.sp,
                          ),
                          Text("${data.distance} km"),
                          const Spacer(),
                          Icon(
                            Icons.currency_rupee_outlined,
                            color: AppColors.greyTextColor,
                            size: 10.sp,
                          ),
                          Text(
                            "${data.fees}",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.greyTextColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            color: AppColors.greyTextColor,
                            size: 10.sp,
                          ),
                          Text(
                            "${data.startDay} - ${data.endDay} at ${data.startTime} am - ${data.endTime} pm",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.greyTextColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
