import 'package:get/get.dart';
import 'package:pet_care_app/model/product.dart';

class ShopController extends GetxController {
  RxMap<String, List<Product>> categoryProducts = <String, List<Product>>{"FOOD": [], "Vet Items": [], "Accessories": [], "IOT Devices": []}.obs;

  void fetchFoodProducts() {
    categoryProducts.value.assign("FOOD", []);
  }
}
