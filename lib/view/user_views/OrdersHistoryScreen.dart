import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/controller/shop_controller.dart';
import 'package:pet_care_app/utils/app_colors.dart';
import 'package:pet_care_app/widgets/OrderDisplayWidget.dart';

class Ordershistoryscreen extends StatefulWidget {
  const Ordershistoryscreen({super.key});

  @override
  State<Ordershistoryscreen> createState() => _OrdershistoryscreenState();
}

class _OrdershistoryscreenState extends State<Ordershistoryscreen> {
  final controller = Get.find<ShopController>();

  @override
  void initState() {
    super.initState();
    controller.getAllOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Scheduled Appointments",
          style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white),
        ),
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        backgroundColor: AppColors.yellowCircle,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Obx(() {
          final list = controller.orders;
          return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) =>
                  OrderDisplayWidget(order: list[index]));
        }),
      ),
    );
  }
}
