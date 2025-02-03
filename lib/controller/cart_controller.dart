import 'package:get/get.dart';
import '../model/product.dart';

class CartController extends GetxController {
  var cartItems = <Product, int>{}.obs;

  void addToCart(Product product) {
    if (cartItems.containsKey(product)) {
      cartItems[product] = cartItems[product]! + 1;
    } else {
      cartItems[product] = 1;
    }
    update(); 
  }

  void removeFromCart(Product product) {
    if (cartItems.containsKey(product)) {
      if (cartItems[product]! > 1) {
        cartItems[product] = cartItems[product]! - 1;
      } else {
        cartItems.remove(product);
      }
    }
    update(); 
  }

  int getQuantity(Product product) {
    return cartItems[product] ?? 0;
  }

  double get subtotal => cartItems.entries
      .fold(0, (sum, item) => sum + (item.key.price * item.value));

  double get shippingCharges => cartItems.isEmpty ? 0.0 : 50.0; 

  double get total => subtotal + shippingCharges;

  int get cartCount => cartItems.length;
}
