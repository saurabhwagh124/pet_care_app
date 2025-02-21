import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/model/user_pet_model.dart';
import 'package:pet_care_app/view/user_views/pet_screen.dart';

class UserPetWidgetIcon extends StatefulWidget {
  final UserPetModel data;
  const UserPetWidgetIcon({super.key, required this.data});

  @override
  State<UserPetWidgetIcon> createState() => _UserPetWidgetIconState();
}

class _UserPetWidgetIconState extends State<UserPetWidgetIcon> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => Petscreen(
              data: widget.data,
            ));
      },
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.deepOrangeAccent, width: 1.5.w), color: const Color.fromARGB(255, 255, 192, 110), borderRadius: BorderRadius.circular(15.r)),
        height: 150.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              height: 125.h,
              width: 94.w,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.r)),
              // clipBehavior: Clip.hardEdge,
              child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r)), child: Image.network(widget.data.photoUrl ?? "")),
            ),
            Container(
              padding: EdgeInsets.all(10.sp),
              decoration: BoxDecoration(border: Border.all(color: Colors.deepOrange), borderRadius: BorderRadius.circular(15.r)),
              child: Text(
                widget.data.name ?? "",
                style: TextStyle(fontSize: 15.sp, color: Colors.white, fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
    );
  }
}
