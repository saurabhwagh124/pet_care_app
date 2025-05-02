import 'dart:developer';

import 'package:get/get.dart';
import 'package:pet_care_app/model/orders_model.dart';
import 'package:pet_care_app/model/product.dart';
import 'package:pet_care_app/service/shop_service.dart';
import 'package:pet_care_app/utils/user_data.dart';

class ShopController extends GetxController {
  final ShopService shopService = ShopService();
  RxString search = RxString('');
  RxBool isLoading = false.obs;
  RxList<Product> foodList = <Product>[].obs;
  RxList<Product> vetItemsList = <Product>[].obs;
  RxList<Product> accList = <Product>[].obs;
  RxList<Product> iotList = <Product>[].obs;
  RxList<OrdersModel> orders = <OrdersModel>[].obs;
  UserData userData = UserData();
  List<String> category = ["FOOD", "VET_ITEMS", "ACCESSORIES", "IOT_DEVICES"];

  void fetchFoodProducts() async {
    isLoading.value = true;
    foodList.value = await shopService.fetchProductsByCategory("FOOD");
    isLoading.value = false;
  }

  void fetchVetItemsProducts() async {
    isLoading.value = true;
    vetItemsList.value = await shopService.fetchProductsByCategory("VET_ITEMS");
    isLoading.value = false;
  }

  void fetchAccessoriesProducts() async {
    isLoading.value = true;
    accList.value = await shopService.fetchProductsByCategory("ACCESSORIES");
    isLoading.value = false;
  }

  void fetchIotProducts() async {
    isLoading.value = true;
    iotList.value = await shopService.fetchProductsByCategory("IOT_DEVICES");
    isLoading.value = false;
  }

  void fetchAllProducts() {
    isLoading.value = true;
    fetchAccessoriesProducts();
    fetchIotProducts();
    fetchVetItemsProducts();
    fetchFoodProducts();
    isLoading.value = false;
  }

  void addOrders(OrdersModel payload) async {
    int id = userData.read<int>("userId") ?? 0;
    log("user id $id");
    payload.usersId = id;
    orders.add(await shopService.addOrder(payload));
  }

  void getAllOrders() async {
    int id = userData.read<int>("userId") ?? 0;
    orders.value = await shopService.getAllOrders(id);
  }
}
