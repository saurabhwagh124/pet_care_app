import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care_app/controller/shop_controller.dart';
import 'package:pet_care_app/utils/app_colors.dart';
import 'package:pet_care_app/utils/app_images.dart';
import 'package:pet_care_app/view/product_card.dart';

class ShopFood extends StatefulWidget {
  const ShopFood({super.key});

  @override
  State<ShopFood> createState() => _ShopFoodState();
}

class _ShopFoodState extends State<ShopFood> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final shopController = ShopController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: shopController.categoryProducts.keys.length, vsync: this);
    _tabController.addListener(_onTabChange);
  }

  void _onTabChange() {
    setState(() {}); // Trigger rebuild on tab change
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
        leading: const BackButton(color: Colors.black),
        title: const Text('Shop', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {},
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
                    hintText: 'Search keywords...',
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
                  isScrollable: false,
                  labelColor: Colors.black,
                  indicatorColor: Colors.lightBlueAccent,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  unselectedLabelColor: Colors.black,
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
                  tabs: shopController.categoryProducts.keys.map((category) {
                    String icon;
                    switch (category) {
                      case 'Food':
                        icon = AppImages.foodLogoImg;
                        break;
                      case 'Vet Items':
                        icon = AppImages.vetItemImg;
                        break;
                      case 'Accessories':
                        icon = AppImages.accessoriesImg;
                        break;
                      case 'IOT Devices':
                        icon = AppImages.iotDevicesImg;
                        break;
                      default:
                        icon = AppImages.pawIconImg;
                    }
                    return Tab(
                      height: 70.h,
                      icon: Container(
                        height: 40.h,
                        width: 40.w,
                        padding: EdgeInsets.all(10.sp),
                        decoration: BoxDecoration(
                          color: _tabController.index == shopController.categoryProducts.keys.toList().indexOf(category) ? const Color.fromARGB(255, 134, 208, 243) : AppColors.greyIconBox,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Image.asset(icon, color: _tabController.index == shopController.categoryProducts.keys.toList().indexOf(category) ? Colors.white : Colors.black),
                      ),
                      child: Text(
                        category,
                        style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, color: AppColors.greyTextColor, overflow: TextOverflow.ellipsis),
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
        children: shopController.categoryProducts.entries.map((entry) {
          final products = entry.value;
          if (products.isEmpty) {
            return const Center(
              child: Text('No products available for this category.'),
            );
          }
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ProductCard(product: products[index]);
            },
          );
        }).toList(),
      ),
    );
  }
}
