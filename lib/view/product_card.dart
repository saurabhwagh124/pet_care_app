import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care_app/model/product.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int _quantity = 0;

  void _addToCart() {
    setState(() {
      if (_quantity == 0) {
        _quantity = 1;
      }
    });
  }

  void _increment() {
    setState(() {
      _quantity++;
    });
  }

  void _decrement() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
      } else {
        _quantity = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Positioned(
            top: 15,
            left: 40,
            child: Image.network(
              widget.product.photoUrl ?? "",
              height: 90,
              fit: BoxFit.cover,
            ),
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
                    widget.product.recommendedFor ?? "",
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                (widget.product.discount! == 0)
                    ? const SizedBox.shrink()
                    : Text(
                        widget.product.discount.toString(),
                        style: const TextStyle(fontSize: 10, color: Colors.redAccent, fontWeight: FontWeight.bold),
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
                      widget.product.itemName ?? "",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  // Text(
                  //   widget.product.weight,
                  //   style: const TextStyle(
                  //     fontSize: 12,
                  //     color: Colors.grey,
                  //   ),
                  // ),
                  if (_quantity == 0)
                    InkWell(
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
                  else
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: _decrement,
                          ),
                          Text(
                            '$_quantity',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: _increment,
                          ),
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
  }
}
