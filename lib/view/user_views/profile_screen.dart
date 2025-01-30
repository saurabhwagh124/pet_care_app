import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pet_care_app/view/user_views/add_pet_screen.dart';
import '../../utils/app_images.dart';
import '../../utils/auth_service.dart';
import '../wrapper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final auth = AuthService();
  final User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0XFFF8AE1F),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          user?.displayName ?? "No Name Available",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
        ),
        actions: [
          if (user?.photoURL != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(user!.photoURL!),
              ),
            )
          else
            Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: AssetImage(AppImages.logoImg),
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.network(
                  user!.photoURL!,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    height: 180.h,
                    decoration: BoxDecoration(
                        boxShadow: [
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
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () async {
                                await auth.signOut();
                                Get.back();
                                Get.to(() => const Wrapper());
                              },
                              child: Text(
                                "Sign Out",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            SizedBox(
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
                              user?.phoneNumber ?? "No Phone Number Available",
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 300,
              child: ListView(
                padding: EdgeInsets.all(16),
                children: [
                  buildMenuTile(
                    context,
                    icon: Icons.person,
                    title: "About me",
                    screen: AddPetsPage(),
                  ),
                  buildMenuTile(
                    context,
                    icon: Icons.shopping_bag_outlined,
                    title: "My Orders",
                    screen: AddPetsPage(),
                  ),
                  buildMenuTile(
                    context,
                    icon: Icons.location_on_outlined,
                    title: "My Address",
                    screen: AddPetsPage(),
                  ),
                  buildMenuTile(
                    context,
                    icon: Icons.pets_outlined,
                    title: "Add Pet",
                    screen: AddPetsPage(),
                  ),
                  buildMenuTile(
                    context,
                    icon: Icons.devices_outlined,
                    title: "Add Device",
                    screen: AddPetsPage(),
                  ),
                  buildMenuTile(
                    context,
                    icon: Icons.search,
                    title: "Find Lost Pets",
                    screen: AddPetsPage(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildMenuTile(BuildContext context,
    {required IconData icon, required String title, required Widget screen}) {
  return Container(
    margin: EdgeInsets.only(bottom: 12),
    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => screen),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.black),
          SizedBox(width: 16),
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black54),
        ],
      ),
    ),
  );
}
