import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:pet_care_app/controller/shop_controller.dart';
import 'package:pet_care_app/widgets/product_card.dart';

class IotTabView extends StatefulWidget {
  const IotTabView({super.key});

  @override
  State<IotTabView> createState() => _IotTabViewState();
}

class _IotTabViewState extends State<IotTabView> {
  final shopController = ShopController();

  @override
  void initState() {
    super.initState();
    shopController.fetchIotProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final search = shopController.search.value;
      print(search);
      final list = shopController.iotList
          .where((element) => (element.itemName ?? "")
              .toLowerCase()
              .contains(search.toLowerCase()))
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
          return ProductCard(product: list[index]);
        },
      );
    });
  }
}
