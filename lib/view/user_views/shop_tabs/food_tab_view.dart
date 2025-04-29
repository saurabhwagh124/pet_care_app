import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/controller/shop_controller.dart';
import 'package:pet_care_app/widgets/product_card.dart';

class FoodTabView extends StatefulWidget {
  const FoodTabView({super.key});

  @override
  State<FoodTabView> createState() => _FoodTabViewState();
}

class _FoodTabViewState extends State<FoodTabView> {
  final shopController = ShopController();

  @override
  void initState() {
    super.initState();
    shopController.fetchFoodProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final list = shopController.foodList
          .where((element) => element.itemName!
              .toLowerCase()
              .contains(shopController.search.toLowerCase()))
          .toList();
      return GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: list.length,
        itemBuilder: (context, index) {
          return ProductCard(
            product: list[index],
            addToCart: true,
          );
        },
      );
    });
  }
}
