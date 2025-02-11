import 'package:get/get.dart';
import 'package:pet_care_app/model/product.dart';
import '../service/shop_service.dart';

class ShopController extends GetxController {
  final ShopService shopService = Get.find<ShopService>();

  RxMap<String, List> categoryProducts = {
    "FOOD": [],
    "Vet Items": [],
    "Accessories": [],
    "IOT Devices": [],
  }.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllProducts();
  }

  void fetchAllProducts() {
    for (String category in categoryProducts.keys) {
      fetchProductsByCategory(category);
    }
  }

  Future<void> fetchProductsByCategory(String category) async {
    String apiCategory;
    switch (category) {
      case "FOOD":
        apiCategory = "FOOD";
        break;
      case "Vet Items":
        apiCategory = "VET_ITEMS";
        break;
      case "Accessories":
        apiCategory = "ACCESSORIES";
        break;
      case "IOT Devices":
        apiCategory = "IOT_DEVICES";
        break;
      default:
        apiCategory = "UNKNOWN";
    }

    if (apiCategory == "UNKNOWN") {
      return;
    }
    

    List<Product> products =
        await shopService.fetchProductsByCategory(apiCategory);

    if (products.isNotEmpty) {
      categoryProducts[category] = products;
      categoryProducts.refresh();
    } else {}
  }
}
