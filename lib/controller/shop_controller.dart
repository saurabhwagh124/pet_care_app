import 'package:get/get.dart';
import 'package:pet_care_app/model/product.dart';
import 'package:pet_care_app/service/shop_service.dart';

class ShopController extends GetxController {
  final ShopService shopService = ShopService();
  RxList<Product> foodList = <Product>[].obs;
  RxList<Product> vetItemsList = <Product>[].obs;
  RxList<Product> accList = <Product>[].obs;
  RxList<Product> iotList = <Product>[].obs;
  List<String> category = ["FOOD", "VET_ITEMS", "ACCESSORIES", "IOT_DEVICES"];

  void fetchFoodProducts() async {
    foodList.value = await shopService.fetchProductsByCategory("FOOD");
  }

  void fetchVetItemsProducts() async {
    vetItemsList.value = await shopService.fetchProductsByCategory("VET_ITEMS");
  }

  void fetchAccessoriesProducts() async {
    accList.value = await shopService.fetchProductsByCategory("ACCESSORIES");
  }

  void fetchIotProducts() async {
    iotList.value = await shopService.fetchProductsByCategory("IOT_DEVICES");
  }
}
