import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care_app/utils/app_colors.dart';
import 'package:pet_care_app/utils/app_images.dart';
import 'package:pet_care_app/view/explore_tabs/boarding_tab_view.dart';
import 'package:pet_care_app/view/explore_tabs/groom_tab_view.dart';
import 'package:pet_care_app/view/explore_tabs/veterniary_tab_view.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.yellowCircle,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(10.r),
                child: Text(
                  "Hello, How may I help you?",
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                ),
              ),
              TabBar(
                labelColor: Colors.blue,
                dividerColor: Colors.black,
                indicatorColor: Colors.transparent,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(
                    height: 60.h,
                    icon: Container(
                      height: 40.h,
                      width: 40.w,
                      padding: EdgeInsets.all(10.sp),
                      decoration: BoxDecoration(
                        color: AppColors.greyIconBox,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Image.asset(AppImages.vetLogoImg),
                    ),
                    child: Text(
                      "Veterinary",
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: AppColors.greyTextColor),
                    ),
                  ),
                  Tab(
                    height: 60.h,
                    icon: Container(
                      height: 40.h,
                      width: 40.w,
                      padding: EdgeInsets.all(10.sp),
                      decoration: BoxDecoration(
                        color: AppColors.greyIconBox,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Image.asset(AppImages.groomLogoImg),
                    ),
                    child: Text(
                      "Grooming",
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: AppColors.greyTextColor),
                    ),
                  ),
                  Tab(
                    height: 60.h,
                    icon: Container(
                      height: 40.h,
                      width: 40.w,
                      padding: EdgeInsets.all(10.sp),
                      decoration: BoxDecoration(
                        color: AppColors.greyIconBox,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Image.asset(AppImages.boardLogoImg),
                    ),
                    child: Text(
                      "Boarding",
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: AppColors.greyTextColor),
                    ),
                  )
                ],
              ),
              const Expanded(
                child: TabBarView(
                  children: [VeterniaryTabView(), GroomTabView(), BoardingTabView()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
