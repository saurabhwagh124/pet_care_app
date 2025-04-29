import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/controller/shop_controller.dart';
import 'package:pet_care_app/widgets/product_card.dart';

class AccessoriesTabView extends StatefulWidget {
  const AccessoriesTabView({super.key});

  @override
  State<AccessoriesTabView> createState() => _AccessoriesTabViewState();
}

class _AccessoriesTabViewState extends State<AccessoriesTabView> {
  final shopController = ShopController();

  @override
  void initState() {
    super.initState();
    shopController.fetchAccessoriesProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final search = shopController.search.value;
      final list = shopController.accList
          .where((element) =>
              element.itemName!.toLowerCase().contains(search.toLowerCase()))
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
