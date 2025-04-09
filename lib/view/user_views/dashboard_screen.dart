import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care_app/controller/shop_controller.dart';
import 'package:pet_care_app/controller/user_pet_controller.dart';
import 'package:pet_care_app/service/notification_service.dart';
import 'package:pet_care_app/utils/app_images.dart';
import 'package:pet_care_app/utils/auth_service.dart';
import 'package:pet_care_app/utils/enums.dart';
import 'package:pet_care_app/view/category_screen.dart';
import 'package:pet_care_app/view/user_views/add_pet_screen.dart';
import 'package:pet_care_app/view/user_views/explore_screen.dart';
import 'package:pet_care_app/view/user_views/profile_screen.dart';
import 'package:pet_care_app/view/user_views/scheduled_appointments_screen.dart';
import 'package:pet_care_app/view/user_views/shop_food_screen.dart';
import 'package:pet_care_app/widgets/user_pet_widget_icon.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool nightMode = false;
  final notificationService = NotificationService();
  final userPetController = UserPetController();
  final shopController = ShopController();
  final auth = AuthService();
  final User? user = FirebaseAuth.instance.currentUser;
  int _selectedIndex = 0;
  List<Widget> screens = [
    const DashboardScreen(),
    const ExploreScreen(),
    const ShopFood(),
    const ProfileScreen()
  ];

  @override
  void initState() {
    userPetController.fetchUserPets();
    notificationService.getFcmtoken();
    shopController.fetchFoodProducts();
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text(
          "Hey ${user!.displayName}, ",
          style: GoogleFonts.fredoka(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer(); // Open drawer using key
          },
        ),
        actions: [
          GestureDetector(
            // onTap: () async {
            //   await showDialog(
            //     context: context,
            //     builder: (context) => AlertDialog(
            //       title: Text(
            //         "Profile Options",
            //         style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w800),
            //       ),
            //       content: SizedBox(
            //         height: 100.h,
            //         child: Column(
            //           spacing: 10.h,
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Container(
            //               color: const Color.fromARGB(255, 242, 188, 184),
            //               padding: const EdgeInsets.all(3),
            //               child: GestureDetector(
            //                 onTap: () async {
            //                   await auth.signOut();
            //                   Get.back();
            //                   Get.to(() => const Wrapper());
            //                 },
            //                 child: Row(
            //                   children: [
            //                     Icon(Icons.logout_outlined, color: Colors.red, size: 20.sp),
            //                     SizedBox(width: 20.w),
            //                     Text(
            //                       "Sign out",
            //                       style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w800),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ),
            //             Container(
            //               color: const Color.fromARGB(255, 219, 245, 128),
            //               padding: const EdgeInsets.all(3),
            //               child: GestureDetector(
            //                 onTap: () {
            //                   Get.to(() => const ForgotPasswordScreen());
            //                 },
            //                 child: Row(
            //                   children: [
            //                     Icon(Icons.lock_reset_outlined, color: Colors.yellow, size: 20.sp),
            //                     SizedBox(width: 20.w),
            //                     Text(
            //                       "Forgot Password",
            //                       style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w800),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             )
            //           ],
            //         ),
            //       ),
            //     ),
            //   );
            // },

            child: Container(
              margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
              padding: EdgeInsets.all(2.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Colors.white,
              ),
              child: Image.asset(AppImages.logoImg),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.orangeAccent),
              child: Text(
                "Menu",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.info_outline, color: Colors.black),
              title: const Text("General Breeds Info"),
              onTap: () {
                Get.back(); // Close drawer
                Get.to(() => CategoryScreen()); // Navigate to your page
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.access_time,
                color: Colors.black,
              ),
              title: const Text("Scheduled Appointments"),
              onTap: () {
                Get.back();
                Get.to(() => ScheduledAppointmentsScreen());
              },
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 45.h, right: 17.w, left: 17.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, 1),
                          blurRadius: 3.5,
                          color: Color.fromRGBO(0, 0, 0, 0.20))
                    ]),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(top: 15.h, left: 20.w, right: 20.w),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 26.h,
                            child: Image.asset(AppImages.pawIconImg),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            "My Pets",
                            style: GoogleFonts.fredoka(
                                fontWeight: FontWeight.w700, fontSize: 20.sp),
                          ),
                          const Spacer()
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 21.w, right: 11.w, bottom: 15.h),
                      child: SizedBox(
                        height: 180.h,
                        child: Obx(() => (userPetController.userPetList.isEmpty)
                            ? Column(
                                spacing: 10.h,
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
                                      backgroundColor: const Color.fromARGB(
                                          255, 159, 221, 250),
                                      child: Icon(
                                        Icons.add_outlined,
                                        color: Colors.white,
                                        size: 40.sp,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : (userPetController.userPetListStatus ==
                                    ApiStatus.LOADING)
                                ? Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.greenAccent,
                                      strokeWidth: 4.sp,
                                    ),
                                  )
                                : (userPetController.userPetListStatus ==
                                        ApiStatus.SUCCESS)
                                    ? ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) =>
                                            UserPetWidgetIcon(
                                              data: userPetController
                                                  .userPetList[index],
                                            ),
                                        separatorBuilder: (context, index) =>
                                            SizedBox(
                                              width: 10.h,
                                            ),
                                        itemCount: userPetController
                                            .userPetList.length)
                                    : const SnackBar(
                                        content: Text("Something went wrong"))),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0, 1),
                            blurRadius: 3.5,
                            color: Color.fromRGBO(0, 0, 0, 0.20))
                      ]),
                  padding: EdgeInsets.all(20.r),
                  child: Column(children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 25.h,
                          child: const Icon(Icons.access_time_rounded),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          "schedules",
                          style: GoogleFonts.fredoka(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                  ])),
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
                    ]),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 25.h,
                          child: Image.asset(AppImages.petFoodIconImg),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          "Pet Food",
                          style: GoogleFonts.fredoka(
                              fontSize: 20.sp, fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Obx(() {
                      if (shopController.foodList.isEmpty) {
                        return Center(
                          child: Text(
                            "No food items available",
                            style: GoogleFonts.fredoka(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }
                      return SizedBox(
                          height: 150.h,
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: shopController.foodList.length,
                              itemBuilder: (context, index) {
                                final product = shopController.foodList[index];
                                return Container(
                                  width: 130.w,
                                  margin: EdgeInsets.only(
                                      right: 10.w, bottom: 10.w),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 60.h,
                                        child: Image.network(
                                            product.photoUrl ?? "",
                                            fit: BoxFit.cover),
                                      ),
                                      SizedBox(
                                        width: 15.w,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 120.w,
                                            child: Text(
                                              overflow: TextOverflow.clip,
                                              product.itemName ?? "",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.fredoka(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 5.h),
                                          Text(
                                            "₹${product.price?.toStringAsFixed(2)}",
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(const ShopFood());
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(5.sp),
                                          decoration: const BoxDecoration(
                                            color: Colors.black,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.shopping_bag_outlined,
                                            color: Colors.white,
                                            size: 20.sp,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }));
                    }),
                  ],
                ),
              ),
              SizedBox(
                height: 50.h,
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: NavigationBar(
            backgroundColor: Colors.orange.withOpacity(0.8),
            elevation: 0,
            height: 70,
            selectedIndex: _selectedIndex,
            onDestinationSelected: (value) {
              if (_selectedIndex != value) {
                setState(() {
                  _selectedIndex = value;
                });
                Get.to(() => screens[value]);
              }
              _selectedIndex = 0;
            },
            indicatorColor: Colors.orangeAccent.withOpacity(0.2),
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            destinations: const [
              NavigationDestination(
                selectedIcon: Icon(Icons.home, color: Colors.white, size: 30),
                icon: Icon(Icons.home_outlined, color: Colors.grey),
                label: 'Home',
              ),
              NavigationDestination(
                selectedIcon:
                    Icon(Icons.explore, color: Colors.white, size: 30),
                icon: Icon(Icons.explore_outlined, color: Colors.grey),
                label: 'Explore',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.shopping_bag,
                    color: Colors.orangeAccent, size: 30),
                icon: Icon(Icons.shopping_bag_outlined, color: Colors.grey),
                label: 'Shop',
              ),
              NavigationDestination(
                selectedIcon:
                    Icon(Icons.pets, color: Colors.orangeAccent, size: 30),
                icon: Icon(Icons.pets_outlined, color: Colors.grey),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
