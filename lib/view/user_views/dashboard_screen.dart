import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care_app/controller/user_pet_controller.dart';
import 'package:pet_care_app/utils/app_images.dart';
import 'package:pet_care_app/utils/auth_service.dart';
import 'package:pet_care_app/view/user_views/add_pet_screen.dart';
import 'package:pet_care_app/view/user_views/explore_screen.dart';
import 'package:pet_care_app/view/user_views/forgot_password_screen.dart';
import 'package:pet_care_app/view/user_views/profile_screen.dart';
import 'package:pet_care_app/view/user_views/shop_food_screen.dart';
import 'package:pet_care_app/view/wrapper.dart';
import 'package:pet_care_app/widgets/user_pet_widget_icon.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final userPetController = UserPetController();
  final auth = AuthService();
  final User? user = FirebaseAuth.instance.currentUser;
  int _selectedIndex = 0;
  List<Widget> screens = [const DashboardScreen(), const ExploreScreen(), const ShopFood(), const ProfileScreen()];

  @override
  void initState() {
    userPetController.fetchUserPets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        automaticallyImplyLeading: false,
        title: Text(
          "Hey ${user!.displayName}, ",
          style: GoogleFonts.fredoka(fontSize: 15.sp, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text(
                          "Profile Options",
                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w800),
                        ),
                        content: SizedBox(
                          height: 100.h,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                color: const Color.fromARGB(255, 242, 188, 184),
                                padding: const EdgeInsets.all(3),
                                child: GestureDetector(
                                  onTap: () async {
                                    await auth.signOut();
                                    Get.back();
                                    Get.to(() => const Wrapper());
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.logout_outlined,
                                        color: Colors.red,
                                        size: 20.sp,
                                      ),
                                      SizedBox(
                                        width: 20.w,
                                      ),
                                      Text(
                                        "Sign out",
                                        style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w800),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Container(
                                color: const Color.fromARGB(255, 219, 245, 128),
                                padding: const EdgeInsets.all(3),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(() => const ForgotPasswordScreen());
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.lock_reset_outlined,
                                        color: Colors.yellow,
                                        size: 20.sp,
                                      ),
                                      SizedBox(
                                        width: 20.w,
                                      ),
                                      Text(
                                        "Forgot Password",
                                        style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w800),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ));
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
              // height: 62,
              // width: 62,
              padding: EdgeInsets.all(2.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Colors.white,
              ),
              child: Image.asset(AppImages.logoImg),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 45.h, right: 17.w, left: 17.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(8.r), boxShadow: const [BoxShadow(offset: Offset(0, 1), blurRadius: 3.5, color: Color.fromRGBO(0, 0, 0, 0.20))]),
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
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            "My Pets",
                            style: GoogleFonts.fredoka(fontWeight: FontWeight.w700, fontSize: 20.sp),
                          ),
                          const Spacer()
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 21.w, right: 21.w),
                      child: SizedBox(
                        height: 160.h,
                        child: Obx(() => (userPetController.userPetList.isEmpty)
                            ? Column(
                                spacing: 10.h,
                                children: [
                                  Text("No Pets Found", style: GoogleFonts.fredoka(fontWeight: FontWeight.w700, fontSize: 16.sp)),
                                  IconButton(
                                    onPressed: () {
                                      Get.to(() => const AddPetsPage());
                                    },
                                    icon: CircleAvatar(
                                      radius: 35.r,
                                      backgroundColor: const Color.fromARGB(255, 159, 221, 250),
                                      child: Icon(
                                        Icons.add_outlined,
                                        color: Colors.white,
                                        size: 40.sp,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => UserPetWidgetIcon(
                                      data: userPetController.userPetList[index],
                                    ),
                                separatorBuilder: (context, index) => SizedBox(
                                      width: 10.h,
                                    ),
                                itemCount: userPetController.userPetList.length)),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white, borderRadius: BorderRadius.circular(8.r), boxShadow: const [BoxShadow(offset: Offset(0, 1), blurRadius: 3.5, color: Color.fromRGBO(0, 0, 0, 0.20))]),
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
                    color: Colors.white, borderRadius: BorderRadius.circular(8.r), boxShadow: const [BoxShadow(offset: Offset(0, 1), blurRadius: 3.5, color: Color.fromRGBO(0, 0, 0, 0.20))]),
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
                          style: GoogleFonts.fredoka(fontSize: 20.sp, fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      padding: EdgeInsets.all(10.sp),
                      decoration: BoxDecoration(
                          color: Colors.white, borderRadius: BorderRadius.circular(8.r), boxShadow: const [BoxShadow(offset: Offset(0, 1), blurRadius: 3.5, color: Color.fromRGBO(0, 0, 0, 0.20))]),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 67.h,
                            child: Image.asset(AppImages.josiDogFoodImg),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            "Josi Dog Master Mix\n 900g",
                            style: GoogleFonts.fredoka(fontSize: 12.sp, fontWeight: FontWeight.w600),
                          ),
                          const Spacer(),
                          Container(
                            margin: EdgeInsets.all(5.sp),
                            decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                            padding: EdgeInsets.all(5.sp),
                            child: Icon(
                              Icons.shopping_bag_outlined,
                              color: Colors.white,
                              size: 30.sp,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      padding: EdgeInsets.all(10.sp),
                      decoration: BoxDecoration(
                          color: Colors.white, borderRadius: BorderRadius.circular(8.r), boxShadow: const [BoxShadow(offset: Offset(0, 1), blurRadius: 3.5, color: Color.fromRGBO(0, 0, 0, 0.20))]),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 67.h,
                            child: Image.asset('assets/images/HappyDogFood.png'),
                          ),
                          SizedBox(
                            width: 10.h,
                          ),
                          Text(
                            "Happy Dog Profi Mix\n 500g",
                            style: GoogleFonts.fredoka(fontSize: 12.sp, fontWeight: FontWeight.w600),
                          ),
                          const Spacer(),
                          Container(
                            margin: EdgeInsets.all(5.sp),
                            decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                            padding: EdgeInsets.all(5.sp),
                            child: Icon(
                              Icons.shopping_bag_outlined,
                              color: Colors.white,
                              size: 30.sp,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.orangeAccent,
        selectedIndex: _selectedIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(
              Icons.house_outlined,
              color: Colors.white,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.navigation,
              color: Colors.white,
            ),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.shopping_bag_outlined,
              color: Colors.white,
            ),
            label: 'Shop',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.pets,
              color: Colors.white,
            ),
            label: 'Profile',
          )
        ],
        onDestinationSelected: (value) {
          setState(() {
            _selectedIndex = value;
            Get.to(() => screens[value]);
            _selectedIndex = 0;
          });
        },
        indicatorColor: Colors.orange,
        indicatorShape: Border.all(color: Colors.red),
      ),
    );
  }
}
