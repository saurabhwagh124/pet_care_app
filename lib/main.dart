import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pet_care_app/controller/appointment_controller.dart';
import 'package:pet_care_app/controller/base_breed_controller.dart';
import 'package:pet_care_app/controller/cart_controller.dart';
import 'package:pet_care_app/controller/orders_controller.dart';
import 'package:pet_care_app/controller/pet_services_controller.dart';
import 'package:pet_care_app/controller/review_controller.dart';
import 'package:pet_care_app/controller/shop_controller.dart';
import 'package:pet_care_app/controller/user_controller.dart';
import 'package:pet_care_app/controller/user_pet_controller.dart';
import 'package:pet_care_app/controller/vet_doc_controller.dart';
import 'package:pet_care_app/service/notification_service.dart';
import 'package:pet_care_app/view/DeliveryScreen.dart';
import 'package:pet_care_app/view/add_notifications_screen.dart';
import 'package:pet_care_app/view/admin_dashboard_screen.dart';
import 'package:pet_care_app/view/boardingmanagement.dart';
import 'package:pet_care_app/view/servicescreen.dart';
import 'package:pet_care_app/view/shop_item_screen.dart';
import 'package:pet_care_app/view/splash_screen.dart';
import 'package:pet_care_app/view/user_views/add_pet_screen.dart';
import 'package:pet_care_app/view/user_views/address_page.dart';
import 'package:pet_care_app/view/user_views/dashboard_screen.dart';
import 'package:pet_care_app/view/user_views/orders_history_screen.dart';
import 'package:pet_care_app/view/veterinaryscreen.dart';

import 'firebase_options.dart';

void main() async {
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
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.orange, brightness: Brightness.light),
            textTheme: TextTheme(
              titleLarge: GoogleFonts.fredoka(
                textStyle: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              titleMedium: GoogleFonts.fredoka(
                textStyle: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              bodyMedium: GoogleFonts.fredoka(
                textStyle: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          initialBinding: BindingsBuilder(() {
            Get.put(AppointmentController());
            Get.put(BaseBreedController());
            Get.put(CartController());
            Get.put(OrdersController());
            Get.put(PetServicesController());
            Get.put(ReviewController());
            Get.put(ShopController());
            Get.put(UserController());
            Get.put(UserPetController());
            Get.put(VetDocController());
          }),
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
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
            // GetPage(
            //     name: '/AppointmentsScreen',
            //     page: () => const AppointmentsScreen()),
            GetPage(name: '/DeliveryScreen', page: () => Deliveryscreen()),
            GetPage(
                name: '/ServicesScreen', page: () => const ServicesScreen()),
            GetPage(
                name: '/BoardingManagementScreen',
                page: () => const BoardingManagementScreen()),
            GetPage(
                name: '/VeterinaryScreen',
                page: () => const Veterinaryscreen()),
            GetPage(
                name: '/ShopItemScreen', page: () => const ShopItemScreen()),
            GetPage(name: '/AddPetsPage', page: () => const AddPetsPage()),
            GetPage(name: '/AddressPage', page: () => const AddressPage()),
            GetPage(
                name: '/OrdersHistoryScreen',
                page: () => const OrdersHistoryScreen())
          ],
        );
      },
    );
  }
}
