import 'dart:developer';

import 'package:get/get.dart';
import 'package:pet_care_app/model/product.dart';
import 'package:pet_care_app/service/orders_service.dart';

class OrdersController extends GetxController {
  final service = OrdersService();
  RxBool isLoading = false.obs;
  RxList<Product> ordersItems = <Product>[].obs;

  void fetchOrderItems(List<int> list) async {
    try {
      isLoading.value = true;
      ordersItems.value = await service.fetchOrderItems(list);
      isLoading.value = false;
    } on Exception catch (e) {
      log(e.toString());
    }
  }
}
