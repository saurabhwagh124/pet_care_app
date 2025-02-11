import 'package:get/get.dart';
import '../model/product.dart';

class CartController extends GetxController {
  var cartItems = <Product, int>{}.obs;

  double get subtotal {
    return cartItems.entries.fold(0, (total, entry) {
      double discountedPrice = entry.key.price! * (1 - (entry.key.discount! / 100));
      return total + (discountedPrice * entry.value);
    });
  }

  double get totalDiscount {
    return cartItems.entries.fold(0, (total, entry) {
      double discountAmount = (entry.key.price! * (entry.key.discount! / 100)) * entry.value;
      return total + discountAmount;
    });
  }

  double get shippingCharges => cartItems.isEmpty ? 0 : 50;  // Example shipping charge

  double get total => subtotal + shippingCharges;

  void addToCart(Product product) {
    if (cartItems.containsKey(product)) {
      cartItems[product] = cartItems[product]! + 1;
    } else {
      cartItems[product] = 1;
    }
    update();
  }

  void removeFromCart(Product product) {
    if (cartItems.containsKey(product) && cartItems[product]! > 1) {
      cartItems[product] = cartItems[product]! - 1;
    } else {
      cartItems.remove(product);
    }
    update();
  }
}
