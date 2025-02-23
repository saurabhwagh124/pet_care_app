import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pet_care_app/controller/appointment_controller.dart';
import 'package:pet_care_app/controller/cart_controller.dart';
import 'package:pet_care_app/view/admin_dashboard_screen.dart';
import 'package:pet_care_app/view/appointmentscreen.dart';
import 'package:pet_care_app/view/boardingmanagement.dart';
import 'package:pet_care_app/view/groomingmanagementscreen.dart';
import 'package:pet_care_app/view/petmanagementscreen.dart';
import 'package:pet_care_app/view/servicescreen.dart';
import 'package:pet_care_app/view/shopitem.dart';
import 'package:pet_care_app/view/usermanagement.dart';
import 'package:pet_care_app/view/veterinaryscreen.dart';
import 'package:pet_care_app/view/wrapper.dart';

import 'firebase_options.dart';

void main() async {
  Get.put(CartController());
  Get.put(AppointmentController());
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: false,
      designSize: const Size(360, 690),
      builder: (_, child) {
        return GetMaterialApp(
          // theme: ThemeData(
          //   primarySwatch: Colors.orange,
          //   textTheme: GoogleFonts.fredokaTextTheme()
          // ),
          // darkTheme: ThemeData(
          //   primarySwatch: Colors.red,
          //   textTheme: GoogleFonts.fredokaTextTheme()
          // ),
          debugShowCheckedModeBanner: false,
          home: const Wrapper(),
          initialRoute: '/',
          getPages: [
            GetPage(name: '/', page: () => const AdminDashboardScreen()),
            GetPage(name: '/pet', page: () => PetManagementScreen()),
            GetPage(name: '/grooming', page: () => GroomingManagementScreen()),
            GetPage(name: '/appointments', page: () => AppointmentsScreen()),
            GetPage(name: '/parks', page: () => UserManagementScreen()),
            GetPage(name: '/services', page: () => ServicesScreen()),
            GetPage(name: '/boarding', page: () => BoardingManagementScreen()),
            GetPage(name: '/veterinary', page: () => const Veterinaryscreen()),
            GetPage(name: '/shopitem', page: () => ShopItemScreen()),
          ],
        );
      },
    );
  }
}
