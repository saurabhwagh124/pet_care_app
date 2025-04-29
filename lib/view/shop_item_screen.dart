import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/controller/shop_controller.dart';
import 'package:pet_care_app/widgets/admin/add_edit_shopitem.dart';
import 'package:pet_care_app/widgets/product_card.dart';

class ShopItemScreen extends StatefulWidget {
  const ShopItemScreen({super.key});

  @override
  State<ShopItemScreen> createState() => _ShopItemScreenState();
}

class _ShopItemScreenState extends State<ShopItemScreen> {
  final shopController = ShopController();

  @override
  void initState() {
    super.initState();
    shopController.fetchAllProducts();
  }

  @override
  void dispose() {
    shopController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop_Item List'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(), // Navigate back to the previous screen
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 40, right: 40),
        child: Column(
          children: [
            DropdownButtonFormField(
                menuMaxHeight: 200,
                itemHeight: 40,
                items: [
                  dropDownItems("All"),
                  dropDownItems("Food"),
                  dropDownItems("Vet Items"),
                  dropDownItems("Iot Items"),
                  dropDownItems("Accessories")
                ],
                onChanged: (value) {}),
            Expanded(
              child: Obx(() {
                final list = [
                  ...shopController.vetItemsList,
                  ...shopController.iotList,
                  ...shopController.foodList,
                  ...shopController.accList,
                ];

                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ProductCard(
                        addToCart: false,
                        product: list[index],
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Get.to(() => AddUpdateItemView());
        },
      ),
    );
  }

  DropdownMenuItem dropDownItems(String text) {
    return DropdownMenuItem(value: text, child: Text(text));
  }
}
