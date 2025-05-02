import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pet_care_app/model/product.dart';
import 'package:pet_care_app/network/api_endpoints.dart';

class OrdersService extends GetxService {
  String token = "";

  Future<List<Product>> fetchOrderItems(List<int> list) async {
    token = await FirebaseAuth.instance.currentUser!.getIdToken() ?? "";
    final headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json"
    };
    try {
      log(list.toString());
      final response = await http.post(Uri.parse(ApiEndpoints.getOrderItemsUrl),
          headers: headers, body: jsonEncode(list));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body) as List<dynamic>;
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load data: ${response.statusCode} ");
      }
    } catch (e) {
      log("fetch order items service error:  $e");
      throw Exception(e.toString());
    }
  }
}
