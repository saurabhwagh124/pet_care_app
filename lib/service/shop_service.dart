import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pet_care_app/model/orders_model.dart';
import 'package:pet_care_app/model/product.dart';

import '../network/api_endpoints.dart';

class ShopService extends GetxService {
  Future<List<Product>> fetchProductsByCategory(String category) async {
    String url = "${ApiEndpoints.getAllShopItemUrl}$category";
    try {
      String token =
          await FirebaseAuth.instance.currentUser?.getIdToken() ?? "";
      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };
      final response = await http.get(Uri.parse(url), headers: headers);

      log("🔹 Response status for $category: ${response.statusCode}");

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        log(response.body);
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load data: ${response.statusCode} ");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<OrdersModel> addOrder(OrdersModel payload) async {
    try {
      String token =
          await FirebaseAuth.instance.currentUser?.getIdToken() ?? "";
      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };
      log("payload: ${jsonEncode(payload.toJson())}");
      final response = await http.post(Uri.parse(ApiEndpoints.postAddOrderUrl),
          headers: headers, body: jsonEncode(payload.toJson()));
      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.body);
        return OrdersModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(
            "Add order service failed else: ${response.toString()}");
      }
    } catch (e) {
      throw Exception("Add order catch service: $e");
    }
  }

  Future<List<OrdersModel>> getAllOrdersByUser(int id) async {
    try {
      String token =
          await FirebaseAuth.instance.currentUser?.getIdToken() ?? "";
      final headers = {"Authorization": "Bearer $token"};
      final url =
          ApiEndpoints.getOrdersByUserUrl.replaceAll("{id}", id.toString());
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<dynamic> data = jsonDecode(response.body);
        List<OrdersModel> orders =
            data.map((json) => OrdersModel.fromJson(json)).toList();
        return orders;
      } else {
        throw Exception("Get all orders else service : ${response.body}");
      }
    } catch (e) {
      throw Exception("Get all orders catch service :$e");
    }
  }

  Future<Product> addProduct(Product payload) async {
    try {
      String token =
          await FirebaseAuth.instance.currentUser?.getIdToken() ?? "";
      final headers = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      };
      final response = await http.post(
          Uri.parse(ApiEndpoints.postAddProductUrl),
          headers: headers,
          body: jsonEncode(payload));
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar("Added successfully", "Item Added Successfully",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
        return Product.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(
            "Add Product service failed else: ${response.toString()}");
      }
    } catch (e) {
      throw Exception("Add Product service failed else: ${e.toString()}");
    }
  }

  Future<Product> editProduct(Product payload) async {
    try {
      String token =
          await FirebaseAuth.instance.currentUser?.getIdToken() ?? "";
      final headers = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      };
      final response = await http.put(Uri.parse(ApiEndpoints.postAddProductUrl),
          headers: headers, body: jsonEncode(payload.toString()));
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar("Edited successfully", "Item Edited Successfully",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
        return Product.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(
            "Add Product service failed else: ${response.toString()}");
      }
    } catch (e) {
      throw Exception("Add Product service failed else: ${e.toString()}");
    }
  }

  Future<void> deleteProduct(int id) async {
    try {
      String token =
          await FirebaseAuth.instance.currentUser?.getIdToken() ?? "";
      final headers = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      };
      final url = ApiEndpoints.deleteItemUrl.replaceAll("{id}", id.toString());
      final response = await http.delete(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        Get.snackbar("Deleted", "Item Deleted Successfully",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      } else {
        Get.snackbar("Error", "Something went wrong",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (e) {
      throw Exception("Delete Product service failed else: ${e.toString()}");
    }
  }
}
