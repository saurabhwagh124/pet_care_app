import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care_app/model/grooming_model.dart';
import 'package:pet_care_app/utils/app_colors.dart';

class GrommingCard extends StatefulWidget {
  final GroomingModel data;
  const GrommingCard({
    required this.data,
    super.key,
  });

  @override
  State<GrommingCard> createState() => _GrommingCardState();
}

class _GrommingCardState extends State<GrommingCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 131.h,
      margin: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
          boxShadow: const [BoxShadow(color: Color.fromRGBO(0, 0, 0, 1), blurRadius: 4, offset: Offset(0, 4))], border: Border.all(), color: Colors.white, borderRadius: BorderRadius.circular(15.r)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    widget.data.imageUrl,
                    width: 60.w,
                  ),
                ),
                SizedBox(width: 15.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.data.name,
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      Wrap(
                        children: [
                          RatingBar.readOnly(
                            halfFilledIcon: Icons.star_half,
                            halfFilledColor: Colors.amberAccent,
                            isHalfAllowed: true,
                            filledIcon: Icons.star,
                            emptyIcon: Icons.star_border,
                            initialRating: widget.data.rating,
                            maxRating: 5,
                            filledColor: Colors.amberAccent,
                            emptyColor: Colors.grey,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '${widget.data.rating} (${widget.data.reviewCount} reviews)',
                            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.black),
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
                  widget.data.isOpen ? 'OPEN' : 'CLOSED',
                  style: TextStyle(
                    color: widget.data.isOpen ? Colors.green : Colors.red,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Icon(Icons.location_pin, size: 10.sp, color: Colors.grey),
                SizedBox(width: 4.w),
                Text(
                  '${widget.data.distance} km',
                  style: const TextStyle(fontSize: 10, color: AppColors.lightGreyText),
                ),
                const Spacer(),
                Icon(
                  Icons.currency_rupee_outlined,
                  color: AppColors.greyTextColor,
                  size: 10.sp,
                ),
                Text(widget.data.price.toStringAsFixed(0), style: TextStyle(fontSize: 10.sp, color: AppColors.lightGreyText)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.access_time, size: 10.sp, color: Colors.grey),
                SizedBox(width: 4.w),
                Text(
                  widget.data.hours,
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
