import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care_app/utils/app_images.dart';
import 'package:pet_care_app/utils/auth_service.dart';
import 'package:pet_care_app/view/petscreen.dart';
import 'package:pet_care_app/view/wrapper.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final auth = AuthService();
  final User? user = FirebaseAuth.instance.currentUser;

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
                              GestureDetector(
                                onTap: () async {
                                  await auth.signOut();
                                  Navigator.pop(context);
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Wrapper()));
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
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 21.w, right: 21.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Petscreen(),
                                      ));
                                },
                                child: Container(
                                  height: 80.h,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
                                  clipBehavior: Clip.hardEdge,
                                  child: Image.asset(AppImages.puppy1Img),
                                ),
                              ),
                              Text(
                                "Pomy",
                                style: TextStyle(fontSize: 15.sp, color: Colors.grey),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height: 80.h,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
                                clipBehavior: Clip.hardEdge,
                                child: Image.asset(AppImages.rabbit1Img),
                              ),
                              Text(
                                "Fixi",
                                style: TextStyle(fontSize: 15.sp, color: Colors.grey),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height: 80.h,
                                width: 80.w,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
                                clipBehavior: Clip.hardEdge,
                                child: Image.asset(
                                  AppImages.cat1Img,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              Text(
                                "Trix",
                                style: TextStyle(fontSize: 15.sp, color: Colors.grey),
                              )
                            ],
                          )
                        ],
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
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 25.h,
                          child: Image.asset('assets/images/petStatusIcon.png'),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          "Pet Status",
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
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25.r,
                          backgroundImage: AssetImage(AppImages.puppy1Img),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Health",
                                  style: TextStyle(fontSize: 14.sp, color: Colors.black),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                SizedBox(
                                  height: 10.h,
                                  width: 60.w,
                                  child: LinearProgressIndicator(
                                    backgroundColor: Colors.grey[300],
                                    value: 0.8,
                                    color: Colors.greenAccent,
                                  ),
                                ),
                                SizedBox(
                                  width: 7.w,
                                ),
                                Text(
                                  "80%",
                                  style: TextStyle(fontSize: 14.sp, color: Colors.greenAccent),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Food",
                                  style: TextStyle(fontSize: 14.sp, color: Colors.black),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                SizedBox(
                                  height: 10.h,
                                  width: 60.w,
                                  child: LinearProgressIndicator(
                                    backgroundColor: Colors.grey[300],
                                    value: 0.5,
                                    color: Colors.pinkAccent,
                                  ),
                                ),
                                SizedBox(
                                  width: 7.w,
                                ),
                                Text(
                                  "50%",
                                  style: TextStyle(fontSize: 14.sp, color: Colors.pinkAccent),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Mood",
                                  style: TextStyle(fontSize: 14.sp, color: Colors.black),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                SizedBox(
                                  height: 10.h,
                                  width: 60.w,
                                  child: LinearProgressIndicator(
                                    backgroundColor: Colors.grey[300],
                                    value: 0.8,
                                    color: Colors.pinkAccent,
                                  ),
                                ),
                                SizedBox(
                                  width: 7.w,
                                ),
                                Text(
                                  "80%",
                                  style: TextStyle(fontSize: 14.sp, color: Colors.pinkAccent),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25.r,
                          backgroundImage: AssetImage(AppImages.rabbit1Img),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Health",
                                  style: TextStyle(fontSize: 14.sp, color: Colors.black),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                SizedBox(
                                  height: 10.h,
                                  width: 60.w,
                                  child: LinearProgressIndicator(
                                    backgroundColor: Colors.grey[300],
                                    value: 0.8,
                                    color: Colors.greenAccent,
                                  ),
                                ),
                                SizedBox(
                                  width: 7.w,
                                ),
                                Text(
                                  "80%",
                                  style: TextStyle(fontSize: 14.sp, color: Colors.greenAccent),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Food",
                                  style: TextStyle(fontSize: 14.sp, color: Colors.black),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                SizedBox(
                                  height: 10.h,
                                  width: 60.w,
                                  child: LinearProgressIndicator(
                                    backgroundColor: Colors.grey[300],
                                    value: 0.5,
                                    color: Colors.pinkAccent,
                                  ),
                                ),
                                SizedBox(
                                  width: 7.w,
                                ),
                                Text(
                                  "50%",
                                  style: TextStyle(fontSize: 14.sp, color: Colors.pinkAccent),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Mood",
                                  style: TextStyle(fontSize: 14.sp, color: Colors.black),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                SizedBox(
                                  height: 10.h,
                                  width: 60.w,
                                  child: LinearProgressIndicator(
                                    backgroundColor: Colors.grey[300],
                                    value: 0.8,
                                    color: Colors.pinkAccent,
                                  ),
                                ),
                                SizedBox(
                                  width: 7.w,
                                ),
                                Text(
                                  "80%",
                                  style: TextStyle(fontSize: 14.sp, color: Colors.pinkAccent),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25.r,
                          backgroundImage: AssetImage(AppImages.cat1Img),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Health",
                                  style: TextStyle(fontSize: 14.sp, color: Colors.black),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                SizedBox(
                                  height: 10.h,
                                  width: 60.w,
                                  child: LinearProgressIndicator(
                                    backgroundColor: Colors.grey[300],
                                    value: 0.8,
                                    color: Colors.greenAccent,
                                  ),
                                ),
                                SizedBox(
                                  width: 7.w,
                                ),
                                Text(
                                  "80%",
                                  style: TextStyle(fontSize: 14.sp, color: Colors.greenAccent),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Food",
                                  style: TextStyle(fontSize: 14.sp, color: Colors.black),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                SizedBox(
                                  height: 10.h,
                                  width: 60.w,
                                  child: LinearProgressIndicator(
                                    backgroundColor: Colors.grey[300],
                                    value: 0.5,
                                    color: Colors.pinkAccent,
                                  ),
                                ),
                                SizedBox(
                                  width: 7.w,
                                ),
                                Text(
                                  "50%",
                                  style: TextStyle(fontSize: 14.sp, color: Colors.pinkAccent),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Mood",
                                  style: TextStyle(fontSize: 14.sp, color: Colors.black),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                SizedBox(
                                  height: 10.h,
                                  width: 60.w,
                                  child: LinearProgressIndicator(
                                    backgroundColor: Colors.grey[300],
                                    value: 0.8,
                                    color: Colors.pinkAccent,
                                  ),
                                ),
                                SizedBox(
                                  width: 7.w,
                                ),
                                Text(
                                  "80%",
                                  style: TextStyle(fontSize: 14.sp, color: Colors.pinkAccent),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    const Row(
                      children: [
                        Spacer(),
                        Text(
                          "Check Pets >",
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    )
                  ],
                ),
              ),
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
        selectedIndex: 0,
        destinations: const [
          Icon(
            Icons.house_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.location_pin,
            color: Colors.white,
          ),
          Icon(
            Icons.devices,
            color: Colors.white,
          ),
          Icon(
            Icons.pets,
            color: Colors.white,
          )
        ],
        indicatorColor: Colors.red,
        indicatorShape: Border.all(color: Colors.red),
      ),
    );
  }
}
