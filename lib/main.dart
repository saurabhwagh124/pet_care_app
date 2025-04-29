import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pet_care_app/controller/appointment_controller.dart';
import 'package:pet_care_app/controller/cart_controller.dart';
import 'package:pet_care_app/service/notification_service.dart';
import 'package:pet_care_app/view/add_notifications_screen.dart';
import 'package:pet_care_app/view/admin_dashboard_screen.dart';
import 'package:pet_care_app/view/appointmentscreen.dart';
import 'package:pet_care_app/view/boardingmanagement.dart';
import 'package:pet_care_app/view/groomingmanagementscreen.dart';
import 'package:pet_care_app/view/servicescreen.dart';
import 'package:pet_care_app/view/shopitem.dart';
import 'package:pet_care_app/view/user_views/add_pet_screen.dart';
import 'package:pet_care_app/view/user_views/dashboard_screen.dart';
import 'package:pet_care_app/view/usermanagement.dart';
import 'package:pet_care_app/view/veterinaryscreen.dart';
import 'package:pet_care_app/view/wrapper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'firebase_options.dart';

void main() async {
  Get.put(CartController());
  Get.put(AppointmentController());
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final notificationService = Get.put(NotificationService());
  notificationService.getFcmtoken();
  notificationService.initializeNotifications();
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
          debugShowCheckedModeBanner: false,
          home: const Wrapper(),
          initialRoute: '/',
          getPages: [
            GetPage(
                name: '/AdminDashBoardScreen',
                page: () => const AdminDashboardScreen()),
            GetPage(
                name: '/DashboardScreen', page: () => const DashboardScreen()),
            GetPage(name: '/AddPetsPage', page: () => const AddPetsPage()),
            GetPage(
                name: '/AddNotificationsScreen',
                page: () => const AddNotificationsScreen()),
            GetPage(
                name: '/GroomingManagementScreen',
                page: () => GroomingManagementScreen()),
            GetPage(
                name: '/AppointmentsScreen',
                page: () => AdminDoctorAppointmentsScreen()),
            GetPage(
                name: '/UserManagementScreen',
                page: () => UserManagementScreen()),
            GetPage(
                name: '/ServicesScreen', page: () => const ServicesScreen()),
            GetPage(
                name: '/BoardingManagementScreen',
                page: () => const BoardingManagementScreen()),
            GetPage(
                name: '/VeterinaryScreen',
                page: () => const Veterinaryscreen()),
            GetPage(name: '/ShopItemScreen', page: () => ShopItemScreen()),
          ],
        );
      },
    );
  }
}
