import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/controller/cart_controller.dart';

import '../model/product.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final CartController cartController =
      Get.find<CartController>(); // GetX Controller

  int get _quantity => cartController.cartItems[widget.product] ?? 0;

  void _addToCart() {
    cartController.addToCart(widget.product);
  }

  void _increment() {
    cartController.addToCart(widget.product);
  }

  void _decrement() {
    cartController.removeFromCart(widget.product);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (widget.product.category != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.orange[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          widget.product.category!,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    if (widget.product.recommendedFor != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.orange[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          widget.product.recommendedFor!,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                if (widget.product.photoUrl != null)
                  SizedBox(
                    height: 78,
                    child: Image.network(
                      widget.product.photoUrl!,
                      fit: BoxFit.cover,
                    ),
                  ),

                // Category & Recommended Labels

                const SizedBox(height: 8),
                Text(
                  widget.product.itemName ?? "",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  "RS.${widget.product.price}",
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Obx(() {
              return _quantity == 0
                  ? InkWell(
                      onTap: _addToCart,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.shopping_bag_outlined,
                                color: Colors.black),
                            SizedBox(width: 8),
                            Text(
                              'Add to cart',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: _decrement),
                        Text(
                          '$_quantity',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                            icon: const Icon(Icons.add), onPressed: _increment),
                      ],
                    );
            }),
          ],
        ),
      ),
    );
  }
}
