import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care_app/controller/shop_controller.dart';
import 'package:pet_care_app/utils/app_colors.dart';
import 'package:pet_care_app/utils/app_images.dart';
import 'package:pet_care_app/view/user_views/shop_tabs/accessories_tab_view.dart';
import 'package:pet_care_app/view/user_views/shop_tabs/food_tab_view.dart';
import 'package:pet_care_app/view/user_views/shop_tabs/iot_tab_view.dart';
import 'package:pet_care_app/view/user_views/shop_tabs/vet_items_tab_view.dart';

import 'shop_cart_screen.dart';

class ShopFood extends StatefulWidget {
  const ShopFood({super.key});

  @override
  State<ShopFood> createState() => _ShopFoodState();
}

class _ShopFoodState extends State<ShopFood> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ShopController shopController = ShopController();
  List<Widget> screenList = const [FoodTabView(), VetItemsTabView(), AccessoriesTabView(), IotTabView()];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: shopController.category.length,
      vsync: this,
    );
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
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Shop',
          style: GoogleFonts.fredoka(
            textStyle: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: AppColors.yellowCircle,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () => Get.to(() => const CartScreen()),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(180),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search products...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                child: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  labelColor: Colors.black,
                  indicatorColor: Colors.lightBlueAccent,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  unselectedLabelColor: Colors.black,
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
                  tabs: shopController.category.map((category) {
                    String icon;
                    switch (category) {
                      case 'FOOD':
                        icon = AppImages.foodLogoImg;
                        break;
                      case 'VET_ITEMS':
                        icon = AppImages.vetItemImg;
                        break;
                      case 'ACCESSORIES':
                        icon = AppImages.accessoriesImg;
                        break;
                      case 'IOT_DEVICES':
                        icon = AppImages.iotDevicesImg;
                        break;
                      default:
                        icon = AppImages.pawIconImg;
                    }
                    return Tab(
                      height: 70,
                      icon: Container(
                        height: 40,
                        width: 40,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: _tabController.index == shopController.category.toList().indexOf(category) ? const Color.fromARGB(255, 134, 208, 243) : AppColors.greyIconBox,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.asset(
                          icon,
                          color: _tabController.index == shopController.category.toList().indexOf(category) ? Colors.white : Colors.black,
                        ),
                      ),
                      child: Text(
                        category,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: screenList,
      ),
    );
  }
}
