import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care_app/controller/vet_doc_controller.dart';
import 'package:pet_care_app/utils/app_colors.dart';
import 'package:pet_care_app/utils/app_images.dart';
import 'package:pet_care_app/view/user_views/explore_tabs/boarding_tab_view.dart';
import 'package:pet_care_app/view/user_views/explore_tabs/pet_services_tab_view.dart';
import 'package:pet_care_app/view/user_views/explore_tabs/veterniary_tab_view.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final searchController = TextEditingController();
  final controller = Get.find<VetDocController>();
  final screenList = [
    const VeterniaryTabView(),
    const PetServicesTabView(),
    const BoardingTabView()
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: screenList.length, vsync: this);
    _tabController.addListener(_onTabChange);
  }

  void _onTabChange() {
    setState(() {});
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChange);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Explore",
          style: GoogleFonts.fredoka(
            textStyle: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        backgroundColor: AppColors.yellowCircle,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          spacing: 5.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(10.r),
              child: Text(
                "Hello, How may I help you?",
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),
            ),
            TextFormField(
              controller: searchController,
              onChanged: (value) {
                controller.search.value = value.toString();
              },
              decoration: InputDecoration(
                hintText: "Search vets, services, boarding...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            TabBar(
              controller: _tabController,
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
                      color: (_tabController.index == 0)
                          ? const Color.fromARGB(255, 134, 208, 243)
                          : AppColors.greyIconBox,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Image.asset(AppImages.vetLogoImg),
                  ),
                  child: Text(
                    "Veterinary",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.greyTextColor),
                  ),
                ),
                Tab(
                  height: 60.h,
                  icon: Container(
                    height: 40.h,
                    width: 40.w,
                    padding: EdgeInsets.all(10.sp),
                    decoration: BoxDecoration(
                      color: (_tabController.index == 1)
                          ? const Color.fromARGB(255, 134, 208, 243)
                          : AppColors.greyIconBox,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Image.asset(AppImages.groomLogoImg),
                  ),
                  child: Text(
                    "Pet Services",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.greyTextColor),
                  ),
                ),
                Tab(
                  height: 60.h,
                  icon: Container(
                    height: 40.h,
                    width: 40.w,
                    padding: EdgeInsets.all(10.sp),
                    decoration: BoxDecoration(
                      color: (_tabController.index == 2)
                          ? const Color.fromARGB(255, 134, 208, 243)
                          : AppColors.greyIconBox,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Image.asset(AppImages.boardLogoImg),
                  ),
                  child: Text(
                    "Boarding",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.greyTextColor),
                  ),
                )
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: screenList,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
