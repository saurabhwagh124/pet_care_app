import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care_app/controller/user_controller.dart';
import 'package:pet_care_app/model/users.dart';
import 'package:pet_care_app/utils/app_colors.dart';
import 'package:pet_care_app/utils/auth_service.dart';
import 'package:pet_care_app/utils/user_data.dart';
import 'package:pet_care_app/view/wrapper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final auth = AuthService();
  final controller = Get.find<UserController>();
  UserData userData = UserData();
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final numberController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
    controller.fetchUserData(FirebaseAuth.instance.currentUser?.email ?? "");
    nameController.text = controller.finalUser.value?.displayName ?? "";
    numberController.text = controller.finalUser.value?.phoneNumber ?? "";
    });
    super.initState();
  }

  void _showModalBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Form(
              child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: Column(
              spacing: 10.h,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: GoogleFonts.fredoka(),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  Colors.orangeAccent)), // Remove inner border
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextFormField(
                    controller: numberController,
                    keyboardType:
                        TextInputType.number, // Only allow number input
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(
                          10), // Limit input to 10 digits
                      FilteringTextInputFormatter
                          .digitsOnly // Allow only digits
                    ],
                    decoration: InputDecoration(
                      labelText: 'Phone number',
                      labelStyle: GoogleFonts.fredoka(),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orangeAccent)),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.length != 10) {
                        return 'Please enter a valid 10-digit phone number';
                      }
                      return null;
                    },
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      Users user = controller.finalUser.value!;
                      user.displayName = nameController.text;
                      user.phoneNumber = numberController.text;
                      controller.updateUserDetails(user);
                      Get.back();
                      nameController.clear();
                      numberController.clear();
                    },
                    child: const Text("Save"))
              ],
            ),
          ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 25.sp),
          onPressed: () => Get.back(),
        ),
        backgroundColor: AppColors.yellowCircle,
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
        ),
        // actions: [
        //   if (user?.photoUrl != null)
        //     Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: CircleAvatar(
        //         backgroundImage: NetworkImage(user?.photoUrl ??
        //             "https://i.pinimg.com/736x/1a/a8/d7/1aa8d75f3498784bcd2617b3e3d1e0c4.jpg"),
        //       ),
        //     )
        //   else
        //     Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: CircleAvatar(
        //         backgroundImage: AssetImage(AppImages.logoImg),
        //       ),
        //     ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Obx(() {
          final user = controller.finalUser.value;
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.lightGreen,
              ),
            );
          }
          return Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.network(
                    user?.photoUrl ?? "",
                    width: double.infinity,
                    height: 200.h,
                    fit: BoxFit.cover,
                    errorBuilder: (BuildContext context, Object error,
                        StackTrace? stackTrace) {
                      return Image.asset(
                        'assets/images/personImg.png',
                        width: double.infinity,
                        height: 200.h,
                        fit: BoxFit.cover,
                      );
                    },
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          top: 15, left: 15, right: 15, bottom: 15),
                      // height: 180.h,
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.15),
                                offset: Offset(0, 5.47),
                                blurRadius: 43.48)
                          ],
                          borderRadius: BorderRadius.circular(27),
                          color: Colors.white),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                user?.displayName ?? "No Name Available",
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () async {
                                  await auth.signOut();
                                  userData.remove("user");
                                  userData.write("admin", false);
                                  Get.back();
                                  Get.to(() => const Wrapper());
                                },
                                child: Text(
                                  "Sign Out",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.logout_outlined,
                                color: Colors.red,
                                size: 14.sp,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.email),
                              ),
                              Text(
                                user?.email ?? "No Name Available",
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.phone),
                              ),
                              Text(
                                user?.phoneNumber ??
                                    "No Phone Number Available",
                              ),
                            ],
                          ),
                          // const SizedBox(height: 16),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  nameController.text = user?.displayName ?? "";
                  numberController.text = user?.phoneNumber ?? "";
                  _showModalBottomSheet();
                },
                child: Text(
                  "Edit Profile",
                  style: TextStyle(
                      color: Colors.orangeAccent,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    buildMenuTile(
                      context,
                      icon: Icons.shopping_bag_outlined,
                      title: "My Orders",
                      screen: '/OrdersHistoryScreen',
                    ),
                    buildMenuTile(
                      context,
                      icon: Icons.location_on_outlined,
                      title: "My Address",
                      screen: '/AddressPage',
                    ),
                    buildMenuTile(context,
                        icon: Icons.pets,
                        title: "Add Pet",
                        screen: '/AddPetsPage'),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

Widget buildMenuTile(BuildContext context,
    {required IconData icon, required String title, required String screen}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: InkWell(
      onTap: () {
        Get.toNamed(screen);
      },
      child: Row(
        children: [
          Icon(icon, color: Colors.black),
          const SizedBox(width: 16),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black54),
        ],
      ),
    ),
  );
}
