import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/controller/shopitem_controller.dart';
import 'package:pet_care_app/widgets/admin/add_edit_shopitem.dart';

class ShopItemScreen extends StatelessWidget {
  ShopItemScreen({super.key});
  final shopController = ShopItemController();

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
      body: Obx(() {
        return ListView.builder(
          itemCount: shopController.shopItems.length,
          itemBuilder: (context, index) {
            final item = shopController.shopItems[index];
            return Card(
              child: ListTile(
                leading: Image.network(item.photoUrl, width: 50, height: 50, fit: BoxFit.cover),
                title: Text(item.itemName),
                subtitle: Text("RS${item.discountedPrice} (${item.discount}% off)"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        Get.to(() => AddUpdateItemView(item: item, index: index));
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => shopController.deleteItem(index),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Get.to(() => AddUpdateItemView());
        },
      ),
    );
  }
}
