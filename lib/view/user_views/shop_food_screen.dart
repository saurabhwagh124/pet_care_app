import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care_app/model/product.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../controller/cart_controller.dart';
import 'shop_cart_screen.dart';

class ShopFood extends StatefulWidget {
  const ShopFood({super.key});

  @override
  State<ShopFood> createState() => _ShopFoodState();
}

class _ShopFoodState extends State<ShopFood>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final Map<String, List<Product>> categoryProducts = {
    'Food': [
      Product(
        name: 'Josera Mini Deluxe',
        price: 2000.00,
        image: 'assets/images/josiDogFood.png',
        category: 'Furry',
        weight: '900g',
      ),
      Product(
        name: 'Pedigree Chicken & Vege',
        price: 1500.00,
        image: 'assets/images/josiDogFood.png',
        category: 'Basic',
        weight: '900g',
      ),
    ],
    'Vet Items': [
      Product(
        name: 'Vet Supplement A',
        price: 1200.00,
        image: 'assets/images/vetSupplement.png',
        category: 'Health',
        weight: '500g',
      ),
    ],
    'Accessories': [],
    'DIY Services': [],
  };

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: categoryProducts.keys.length, vsync: this);
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
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'Shop',
          style: GoogleFonts.fredoka(
            textStyle: const TextStyle(
                fontSize: 23, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {
              Get.to(() => const CartScreen());
            },
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
                  isScrollable: true,
                  labelColor: Colors.black,
                  indicatorColor: Colors.blue,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  unselectedLabelColor: Colors.black,
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  unselectedLabelStyle:
                      const TextStyle(fontWeight: FontWeight.normal),
                  tabs: categoryProducts.keys.map((category) {
                    IconData icon;
                    switch (category) {
                      case 'Food':
                        icon = Icons.food_bank;
                        break;
                      case 'Vet Items':
                        icon = Icons.medical_services;
                        break;
                      case 'Accessories':
                        icon = Icons.toys;
                        break;
                      case 'DIY Services':
                        icon = Icons.build;
                        break;
                      default:
                        icon = Icons.help;
                    }
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: _tabController.index ==
                                    categoryProducts.keys
                                        .toList()
                                        .indexOf(category)
                                ? Colors.blue
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(icon, size: 30, color: Colors.black),
                        ),
                        Text(
                          category,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
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
        children: categoryProducts.entries.map((entry) {
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

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();

    return Obx(() {
      int quantity = cartController.getQuantity(product);

      return Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.25),
                offset: Offset(0, 4),
                blurRadius: 4)
          ],
          color: Colors.white,
        ),
        child: Column(
          children: [
            Image.asset(product.image, height: 60.h),
            Text(product.name),
            Text("RS.${product.price}"),
            Text("${product.weight}"),
            if (quantity == 0)
              GestureDetector(
                onTap: () {
                  cartController.addToCart(product);
                },
                child: Column(
                  children: [
                    Divider(),
                    Container(
                      child: const Text("Add to Cart"),
                    ),
                  ],
                ),
              )
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () => cartController.removeFromCart(product),
                  ),
                  Text('$quantity'),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => cartController.addToCart(product),
                  ),
                ],
              ),
          ],
        ),
      );
    });
  }
}
