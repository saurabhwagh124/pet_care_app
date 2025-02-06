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
    return SizedBox(
      height: 150,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Get.to(() => Petscreen(
                    data: widget.data,
                  ));
            },
            child: Container(
              height: 125.h,
              width: 110.w,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
              clipBehavior: Clip.hardEdge,
              child: Image.network(widget.data.photoUrl ?? ""),
            ),
          ),
          Text(
            widget.data.name ?? "",
            style: TextStyle(fontSize: 15.sp, color: Colors.grey),
          )
        ],
      ),
    );
  }
}
