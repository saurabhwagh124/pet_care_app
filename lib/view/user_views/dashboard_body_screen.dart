import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care_app/controller/shop_controller.dart';
import 'package:pet_care_app/controller/user_pet_controller.dart';
import 'package:pet_care_app/utils/app_images.dart';
import 'package:pet_care_app/utils/enums.dart';
import 'package:pet_care_app/view/user_views/add_pet_screen.dart';
import 'package:pet_care_app/view/user_views/shop_food_screen.dart';
import 'package:pet_care_app/widgets/user_pet_widget_icon.dart';

class DashboardBodyScreen extends StatelessWidget {
  final userPetController = Get.find<UserPetController>();
  final shopController = Get.find<ShopController>();

  DashboardBodyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 45.h, right: 17.w, left: 17.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // ===== Your Pets Card =====
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 1),
                  blurRadius: 3.5,
                  color: Color.fromRGBO(0, 0, 0, 0.20),
                )
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 15.h, left: 20.w, right: 20.w),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 26.h,
                        child: Image.asset(AppImages.pawIconImg),
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        "My Pets",
                        style: GoogleFonts.fredoka(
                            fontWeight: FontWeight.w700, fontSize: 20.sp),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.only(
                      left: 21.w, right: 11.w, bottom: 15.h),
                  child: SizedBox(
                    height: 180.h,
                    child: Obx(() {
                      if (userPetController.userPetList.isEmpty) {
                        return Column(
                          children: [
                            Text("No Pets Found",
                                style: GoogleFonts.fredoka(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16.sp)),
                            IconButton(
                              onPressed: () {
                                Get.to(() => const AddPetsPage());
                              },
                              icon: CircleAvatar(
                                radius: 35.r,
                                backgroundColor:
                                    const Color.fromARGB(255, 159, 221, 250),
                                child: Icon(
                                  Icons.add_outlined,
                                  color: Colors.white,
                                  size: 40.sp,
                                ),
                              ),
                            )
                          ],
                        );
                      } else if (userPetController.userPetListStatus ==
                          ApiStatus.LOADING) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.greenAccent,
                            strokeWidth: 4.sp,
                          ),
                        );
                      } else {
                        return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) =>
                              UserPetWidgetIcon(
                            data: userPetController.userPetList[index],
                          ),
                          separatorBuilder: (context, index) =>
                              SizedBox(width: 10.w),
                          itemCount: userPetController.userPetList.length,
                        );
                      }
                    }),
                  ),
                )
              ],
            ),
          ),

          // ===== Schedules Card =====
          SizedBox(height: 20.h),
          Container(
            padding: EdgeInsets.all(20.r),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              boxShadow: const [
                BoxShadow(
                    offset: Offset(0, 1),
                    blurRadius: 3.5,
                    color: Color.fromRGBO(0, 0, 0, 0.20))
              ],
            ),
            child: Row(
              children: [
                Icon(Icons.access_time_rounded, size: 25.sp),
                SizedBox(width: 10.w),
                Text(
                  "Schedules",
                  style: GoogleFonts.fredoka(
                      fontSize: 20.sp, fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),

          // ===== Food Card =====
          SizedBox(height: 20.h),
          Container(
            padding: EdgeInsets.all(20.sp),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              boxShadow: const [
                BoxShadow(
                    offset: Offset(0, 1),
                    blurRadius: 3.5,
                    color: Color.fromRGBO(0, 0, 0, 0.20))
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(AppImages.petFoodIconImg, height: 25.h),
                    SizedBox(width: 10.w),
                    Text(
                      "Pet Food",
                      style: GoogleFonts.fredoka(
                          fontSize: 20.sp, fontWeight: FontWeight.w700),
                    )
                  ],
                ),
                SizedBox(height: 20.h),
                Obx(() {
                  if (shopController.foodList.isEmpty) {
                    return Text(
                      "No food items available",
                      style: GoogleFonts.fredoka(
                          fontSize: 14.sp, fontWeight: FontWeight.w600),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: shopController.foodList.length,
                    itemBuilder: (context, index) {
                      final product = shopController.foodList[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: 10.h),
                        padding: EdgeInsets.all(10.sp),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.r),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 1),
                              blurRadius: 3.5,
                              color: Color.fromRGBO(0, 0, 0, 0.20),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Image.network(
                              product.photoUrl ?? "",
                              height: 60.h,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(width: 10.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.itemName ?? "",
                                  style: GoogleFonts.fredoka(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  "₹${product.price?.toStringAsFixed(2)}",
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),
                                ),
                              ],
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () => Get.to(() => const ShopFood()),
                              child: CircleAvatar(
                                backgroundColor: Colors.black,
                                radius: 20.r,
                                child: Icon(Icons.shopping_bag_outlined,
                                    color: Colors.white, size: 20.sp),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
              ],
            ),
          ),
          SizedBox(height: 50.h)
        ],
      ),
    );
  }
}
