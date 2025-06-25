import 'dart:developer';

import 'package:get/get.dart';
import 'package:pet_care_app/model/orders_model.dart';
import 'package:pet_care_app/model/product.dart';
import 'package:pet_care_app/service/orders_service.dart';

class OrdersController extends GetxController {
  final service = OrdersService();
  RxBool isLoading = false.obs;
  RxList<Product> ordersItems = <Product>[].obs;
  RxList<OrdersModel> orders = <OrdersModel>[].obs;

  void fetchOrderItems(List<int> list) async {
    try {
      isLoading.value = true;
      ordersItems.value = await service.fetchOrderItems(list);
      isLoading.value = false;
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  void getAllOrders() async {
    try {
      isLoading.value = true;
      orders.value = await service.getAllOrders();
      isLoading.value = false;
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  void updateOrder(OrdersModel updatedOrder, int index) async {
    try {
      isLoading.value = true;
      orders.add(await service.updateOrder(updatedOrder));
      orders.removeAt(index);
      isLoading.value = false;
    } catch (e) {
      log(e.toString());
    }
  }
}
