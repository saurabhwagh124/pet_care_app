import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/controller/shop_controller.dart';
import 'package:pet_care_app/widgets/product_card.dart';

class VetItemsTabView extends StatefulWidget {
  const VetItemsTabView({super.key});

  @override
  State<VetItemsTabView> createState() => _VetItemsTabViewState();
}

class _VetItemsTabViewState extends State<VetItemsTabView> {
  final shopController = ShopController();

  @override
  void initState() {
    super.initState();
    shopController.fetchVetItemsProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Obx(() => GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: shopController.vetItemsList.length,
                  itemBuilder: (context, index) {
                    return ProductCard(product: shopController.vetItemsList[index]);
                  },
                )))
      ],
    );
  }
}
