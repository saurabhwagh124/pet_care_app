import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pet_care_app/model/product.dart';

import '../network/api_endpoints.dart';

class ShopService extends GetxService {
  Future<List<Product>> fetchProductsByCategory(String category) async {
    String url = "${ApiEndpoints.baseUrl}/shopItem-by-category/$category";

    try {
      final response = await http.get(Uri.parse(url));

      print("🔹 Response status for $category: ${response.statusCode}");

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load data: ${response.statusCode} ");
      }
    } catch (e) {
      return [];
    }
  }
}
