import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pet_care_app/model/general_review_model.dart';
import 'package:pet_care_app/network/api_endpoints.dart';

class ReviewService extends GetxService {
  Future<String> getToken() async {
    return await FirebaseAuth.instance.currentUser?.getIdToken() ?? "";
  }

  Future<List<GeneralReviewModel>> fetchDoctorReviews(int doctorId) async {
    try {
      final token = await getToken();
      final headers = {"Authorization": "Bearer $token"};
      final url = ApiEndpoints.getDoctorReviewsUrl.replaceAll("{id}", doctorId.toString());
      log(url);
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
        return data.map((json) => GeneralReviewModel.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load doctor reviews: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching doctor reviews: $e");
    }
  }

  Future<List<GeneralReviewModel>> fetchBoardingReviews(int boardingId) async {
    try {
      final token = await getToken();
      final headers = {"Authorization": "Bearer $token"};
      final url = ApiEndpoints.getBoardingReviewsUrl.replaceAll("{id}", boardingId.toString());
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
        return data.map((json) => GeneralReviewModel.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load boarding reviews: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching boarding reviews: $e");
    }
  }

  Future<List<GeneralReviewModel>> fetchServiceReviews(int serviceId) async {
    try {
      final token = await getToken();
      final headers = {"Authorization": "Bearer $token"};
      final url = ApiEndpoints.getServiceReviewsUrl.replaceAll("{id}", serviceId.toString());
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
        return data.map((json) => GeneralReviewModel.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load service reviews: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching service reviews: $e");
    }
  }
}
