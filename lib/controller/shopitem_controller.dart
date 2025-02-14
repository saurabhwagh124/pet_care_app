import 'package:get/get.dart';

import '../model/shopitem_model.dart';

class ShopItemController extends GetxController {
  var shopItems = <ShopItem>[].obs;

  // Add Item
  void addItem(ShopItem item) {
    shopItems.add(item);
  }

  // Update Item
  void updateItem(int index, ShopItem updatedItem) {
    shopItems[index] = updatedItem;
  }

  // Delete Item
  void deleteItem(int index) {
    shopItems.removeAt(index);
  }
}
