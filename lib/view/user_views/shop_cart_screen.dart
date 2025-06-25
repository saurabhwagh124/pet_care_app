import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care_app/controller/cart_controller.dart';
import 'package:pet_care_app/controller/shop_controller.dart';
import 'package:pet_care_app/model/address_model.dart';
import 'package:pet_care_app/model/orders_model.dart';
import 'package:pet_care_app/utils/app_colors.dart';
import 'package:pet_care_app/widgets/select_address_dialog.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Razorpay _razorPay;
  AddressModel? selectedAddress;
  bool selectAddress = false;
  final ShopController shopController = Get.find();
  final CartController cartController = Get.find<CartController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _razorPay = Razorpay();
      _razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      _razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentFailed);
      _razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handlePaymentExternal);
    });
  }

  @override
  void dispose() {
    _razorPay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse success) {
    List<OrderItemsList> orderList = [];
    for (var ele in cartController.cartItems.keys) {
      orderList.add(OrderItemsList(
          id: null,
          itemId: ele.id,
          quantity: cartController.cartItems[ele],
          pricePerItem: ele.discountedPrice));
    }
    OrdersModel order = OrdersModel(
        id: null,
        usersId: null,
        orderItemsList: orderList,
        totalPrice: cartController.total.toInt(),
        address: AddressModel(
            id: selectedAddress?.id ?? 0,
            street: selectedAddress?.street ?? "",
            city: selectedAddress?.city ?? "",
            state: selectedAddress?.state ?? "",
            postalCode: selectedAddress?.postalCode ?? "",
            country: selectedAddress?.country ?? "",
            userEmail: selectedAddress?.userEmail ?? ""),
        status: "PENDING",
        remarks: null,
        createdAt: null);
    shopController.addOrders(order);
    Get.off(() => SimpleDialog(
            alignment: Alignment.center,
            backgroundColor: Colors.white,
            children: [
              CircleAvatar(
                radius: 30.r,
                backgroundColor: Colors.lightGreen,
                child: Icon(
                  Icons.done,
                  size: 20.sp,
                  color: Colors.white,
                ),
              ),
              Text(
                "Order Placed Successfully",
                style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              GestureDetector(
                onTap: () {
                  cartController.cartItems.clear();
                  Get.offAllNamed('/DashboardScreen');
                },
                child: Container(
                  color: Colors.lightGreenAccent,
                  alignment: Alignment.center,
                  height: 30.h,
                  width: 40.w,
                  child: Text(
                    "Ok",
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              )
            ]));
  }

  void _handlePaymentFailed(PaymentFailureResponse failed) {}

  void _handlePaymentExternal(ExternalWalletResponse response) {}

  void openCheckout() async {
    if (!selectAddress) {
      return;
    }
    log("${cartController.total.toInt()} TOtal amount to pay");
    final amount = cartController.total.toInt();
    // const amount = 500;
    var options = {
      'key': 'rzp_test_wqDdQzUfF7ZXt2',
      'amount': amount,
      'name': 'Pet Universe App',
      'description': 'Pet Supplies',
      'prefill': {'contact': '7498816400', 'email': 'petuniverseapp@gmail.com'}
    };
    try {
      _razorPay.open(options);
    } catch (e) {
      throw Exception("Razor pay not working $e");
    }
  }

  Future<void> _openAddressDialog(BuildContext context) async {
    final selected = await showDialog<AddressModel>(
      context: context,
      builder: (context) => const SelectAddressDialog(),
    );
    if (selected != null) {
      selectedAddress = selected;
      selectAddress = true;
    }
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
        centerTitle: true,
        title: Text(
          'Cart',
          style: GoogleFonts.fredoka(
            textStyle: TextStyle(
                fontSize: 23.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white),
          ),
        ),
      ),
      body: Obx(() {
        if (cartController.cartItems.isEmpty) {
          return Center(
              child: Text(
            "Your cart is empty",
            style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black),
          ));
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartController.cartItems.length,
                itemBuilder: (context, index) {
                  final product = cartController.cartItems.keys.toList()[index];
                  final quantity = cartController.cartItems[product]!;
                  final double discountedPrice =
                      product.price! * (1 - (product.discount! / 100));

                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            offset: Offset(0, 4),
                            blurRadius: 4,
                          )
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: ListTile(
                        leading: Image.network(product.photoUrl!, width: 50),
                        title: Text(product.itemName!),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "RS.${product.price} x $quantity",
                              style: const TextStyle(
                                fontSize: 12,
                                decoration: TextDecoration.lineThrough,
                                color: Colors.red,
                              ),
                            ),
                            Text(
                              "RS.${discountedPrice.toStringAsFixed(2)} x $quantity",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () =>
                                  cartController.removeFromCart(product),
                            ),
                            Text('$quantity'),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () =>
                                  cartController.addToCart(product),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey, width: 1),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SummaryRow(title: "Subtotal", value: cartController.subtotal),
                  SummaryRow(
                      title: "Discount Applied",
                      value: cartController.totalDiscount,
                      isDiscount: true),
                  SummaryRow(
                      title: "Shipping Charges",
                      value: cartController.shippingCharges),
                  const Divider(),
                  SummaryRow(
                      title: "Total",
                      value: cartController.total,
                      isBold: true),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      await _openAddressDialog(context);
                      openCheckout();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      "Checkout",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}

class SummaryRow extends StatelessWidget {
  final String title;
  final double value;
  final bool isBold;
  final bool isDiscount;

  const SummaryRow({
    super.key,
    required this.title,
    required this.value,
    this.isBold = false,
    this.isDiscount = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isDiscount ? Colors.green : Colors.black,
            ),
          ),
          Text(
            isDiscount
                ? "- RS.${value.toStringAsFixed(2)}"
                : "RS.${value.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isDiscount ? Colors.green : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
