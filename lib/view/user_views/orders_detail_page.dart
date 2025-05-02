import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/controller/orders_controller.dart';
import 'package:pet_care_app/model/orders_model.dart';
import 'package:pet_care_app/model/product.dart';
import 'package:pet_care_app/utils/app_colors.dart';

class OrdersDetailPage extends StatefulWidget {
  final OrdersModel order;
  const OrdersDetailPage({super.key, required this.order});

  @override
  State<OrdersDetailPage> createState() => _OrdersDetailPageState();
}

class _OrdersDetailPageState extends State<OrdersDetailPage> {
  final controller = Get.find<OrdersController>();

  @override
  void initState() {
    super.initState();
    List<int> list =
        widget.order.orderItemsList.map((e) => e.itemId ?? 0).toList();
    controller.fetchOrderItems(list);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 25.sp),
          onPressed: () => Get.back(),
        ),
        backgroundColor: AppColors.yellowCircle,
        title: Text(
          'Order ID: ${widget.order.id}',
          style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    'Status: ',
                    style: TextStyle(fontSize: 18.sp),
                  ),
                  Chip(
                    label: Text(
                      widget.order.status!.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    backgroundColor: _getStatusColor(widget.order.status!),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 2), // Adjust padding
                    labelPadding: EdgeInsets
                        .zero, // Remove default label padding if needed
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Wrap(
                children: [
                  Text(
                    'Remarks: ',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    widget.order.remarks.toString(),
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16.h,
              ),
              Text(
                'Order Items: ',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                  height: (widget.order.orderItemsList.isEmpty)
                      ? 100.h
                      : widget.order.orderItemsList.length * 100.h,
                  child: Obx(() {
                    final list = controller.ordersItems;
                    if (controller.isLoading.value) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.lightGreen,
                        ),
                      );
                    } else {
                      if (list.isEmpty) {
                        return const Center(
                          child: Text("No Items Here"),
                        );
                      } else {
                        return ListView.builder(
                          itemBuilder: (context, index) =>
                              productCards(list[index], index),
                          itemCount: list.length,
                        );
                      }
                    }
                  })),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Total Items: ${widget.order.orderItemsList.length}"),
                  Text("Total Price: ${widget.order.totalPrice}")
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'CONFIRMED':
        return Colors.green;
      case 'PENDING':
        return Colors.orange;
      case 'CANCELLED':
        return Colors.red;
      default:
        return Colors.grey; // Default color
    }
  }

  Card productCards(Product data, int index) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        spacing: 10.w,
        children: [
          Text("${index + 1}"),
          SizedBox(
            height: 70.h,
            width: 70.w,
            child: Image.network(
              data.photoUrl ?? "",
              fit: BoxFit.fitWidth,
            ),
          ),
          SizedBox(
            width: 100.w,
            child: Text(
              data.itemName ?? "",
              style: TextStyle(overflow: TextOverflow.ellipsis),
            ),
          ),
          Text(data.discountedPrice.toString(),
              style: TextStyle(overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }
}
