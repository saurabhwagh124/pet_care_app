import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/controller/orders_controller.dart';
import 'package:pet_care_app/model/orders_model.dart';
import 'package:pet_care_app/utils/app_colors.dart';
import 'package:pet_care_app/widgets/admin/order_management_card.dart';

class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({super.key});

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  final controller = Get.find<OrdersController>();
  RxString filter = "".obs;
  RxList<OrdersModel> mainList = RxList<OrdersModel>();

  @override
  void initState() {
    controller.getAllOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 25.sp),
            onPressed: () => Get.back(),
          ),
          backgroundColor: AppColors.yellowCircle,
          title: Text(
            'Delivery Management',
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
          child: Column(
            children: [
              Row(
                children: [
                  const Text("Filter by status: "),
                  Container(
                      width: 200.w,
                      padding: EdgeInsets.all(5.sp),
                      child: DropdownButtonFormField(
                        alignment: Alignment.center,
                        dropdownColor: Colors.orange[100],
                        // icon: const Icon(Icons.filter_alt),
                        decoration: const InputDecoration(
                            focusColor: Colors.orangeAccent,
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.orange)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.orange)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.orange))),
                        value: "All",
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        menuMaxHeight: 200.h,
                        items: [
                          dropDownItems("All"),
                          dropDownItems("PENDING"),
                          dropDownItems("CANCELLED"),
                          dropDownItems("DELIVERED"),
                          dropDownItems("SHIPPED"),
                        ],
                        onChanged: (value) {
                          filter.value = value.toString();
                        },
                      ))
                ],
              ),
              Expanded(
                child: Obx(() {
                  final value = filter.value;
                  switch (value) {
                    case "All":
                      mainList.value = controller.orders.toList();
                      break;
                    case "PENDING":
                      mainList.value = controller.orders
                          .where((element) => element.status == ("PENDING"))
                          .toList();
                      break;
                    case "SHIPPED":
                      mainList.value = controller.orders
                          .where((element) => element.status == "SHIPPED")
                          .toList();
                      break;
                    case "DELIVERED":
                      mainList.value = controller.orders
                          .where((element) => element.status == "DELIVERED")
                          .toList();
                      break;
                    case "CANCELLED":
                      mainList.value = controller.orders
                          .where((element) => element.status == "CANCELLED")
                          .toList();
                      break;
                  }
                  if (controller.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.green,
                      ),
                    );
                  }
                  if (mainList.isEmpty) {
                    return const Center(
                      child: Text("No Orders"),
                    );
                  } else {
                    return ListView.builder(
                      itemBuilder: (context, index) => OrderManagementCard(
                        order: mainList[index],
                        index: index,
                      ),
                      itemCount: mainList.length,
                    );
                  }
                }),
              ),
            ],
          ),
        ));
  }

  DropdownMenuItem<String> dropDownItems(String text) {
    return DropdownMenuItem(
      value: text,
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
            fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.black),
      ),
    );
  }
}

enum OrderStatus { PENDING, SHIPPED, DELIVERED, CANCELLED }
