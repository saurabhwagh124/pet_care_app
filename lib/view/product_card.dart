import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/controller/cart_controller.dart';
import 'package:pet_care_app/model/product.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final CartController cartController = CartController(); // GetX Controller

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
    return Obx(() {
      return Container(
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
              top: 15,
              left: 40,
              child: Image.network(widget.product.photoUrl!, height: 90, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 100,
                  width: 100,
                  color: Colors.grey[300], // Placeholder background
                  child: const Icon(Icons.error, color: Colors.red, size: 40), // Error icon
                );
              }),
            ),
            Positioned(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.orange[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      widget.product.category ?? "",
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 100,
              child: SizedBox(
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "RS.${widget.product.price}",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        widget.product.itemName!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    (_quantity == 0)
                        ? InkWell(
                            onTap: _addToCart,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              alignment: Alignment.center,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.shopping_bag_outlined, color: Colors.black),
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
                        : Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(icon: const Icon(Icons.remove), onPressed: _decrement),
                                Text(
                                  '$_quantity',
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                IconButton(icon: const Icon(Icons.add), onPressed: _increment),
                              ],
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
