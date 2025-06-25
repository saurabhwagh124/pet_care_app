import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart' as FB;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pet_care_app/model/general_review_model.dart';
import 'package:pet_care_app/model/users.dart';
import 'package:pet_care_app/network/api_endpoints.dart';

class ReviewService extends GetxService {
  Future<String> getToken() async {
    return await FB.FirebaseAuth.instance.currentUser?.getIdToken() ?? "";
  }

  Future<List<GeneralReviewModel>> fetchDoctorReviews(int doctorId) async {
    try {
      final token = await getToken();
      final headers = {"Authorization": "Bearer $token"};
      final url = ApiEndpoints.getDoctorReviewsUrl
          .replaceAll("{id}", doctorId.toString());
      log(url);
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
        return data.map((json) => GeneralReviewModel.fromJson(json)).toList();
      } else {
        throw Exception(
            "Failed to load doctor reviews: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching doctor reviews: $e");
    }
  }

  Future<List<GeneralReviewModel>> fetchBoardingReviews(int boardingId) async {
    try {
      final token = await getToken();
      final headers = {"Authorization": "Bearer $token"};
      final url = ApiEndpoints.getBoardingReviewsUrl
          .replaceAll("{id}", boardingId.toString());
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
        return data.map((json) => GeneralReviewModel.fromJson(json)).toList();
      } else {
        throw Exception(
            "Failed to load boarding reviews: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching boarding reviews: $e");
    }
  }

  Future<List<GeneralReviewModel>> fetchServiceReviews(int serviceId) async {
    try {
      final token = await getToken();
      final headers = {"Authorization": "Bearer $token"};
      final url = ApiEndpoints.getServiceReviewsUrl
          .replaceAll("{id}", serviceId.toString());
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
        return data.map((json) => GeneralReviewModel.fromJson(json)).toList();
      } else {
        throw Exception(
            "Failed to load service reviews: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching service reviews: $e");
    }
  }

  Future<GeneralReviewModel> addDoctorReview(
      int doctorId, Users user, String review, double reviewScore) async {
    try {
      final token = await getToken();
      final headers = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      };
      final response =
          await http.post(Uri.parse(ApiEndpoints.postDoctorReviewUrl),
              headers: headers,
              body: jsonEncode({
                "id": "0",
                "doctor": {"id": doctorId},
                "users": user.toJson(),
                "reviewDescription": review,
                "reviewScore": reviewScore
              }));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        log(data.toString());
        final review = GeneralReviewModel.fromJson(data);
        log(review.toString());
        return review;
      } else {
        throw Exception("Failed to add doctor review: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error adding doctor review: $e");
    }
  }

  Future<GeneralReviewModel> addBoardingReview(
      int id, Users user, String text, double rating) async {
    try {
      final token = await getToken();
      final headers = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      };
      final response =
          await http.post(Uri.parse(ApiEndpoints.postBoardingReviewUrl),
              headers: headers,
              body: jsonEncode({
                "id": "0",
                "boarding": {"id": id},
                "users": user.toJson(),
                "reviewDescription": text,
                "reviewScore": rating
              }));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final review = GeneralReviewModel.fromJson(data);
        log(review.toString());
        return review;
      } else {
        throw Exception(
            "Failed to add boarding review: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error adding boarding review: $e");
    }
  }

  Future<GeneralReviewModel> addServiceReview(
      int id, Users user, String text, double rating) async {
    try {
      final token = await getToken();
      final headers = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      };
      final response =
          await http.post(Uri.parse(ApiEndpoints.postServiceReviewUrl),
              headers: headers,
              body: jsonEncode({
                "id": "0",
                "petServices": {"id": id},
                "users": user.toJson(),
                "reviewDescription": text,
                "reviewScore": rating
              }));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        log(data);
        final review = GeneralReviewModel.fromJson(data);
        log(review.toString());
        return review;
      } else {
        throw Exception("Failed to add service review: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error adding service review: $e");
    }
  }

  Future<GeneralReviewModel> addItemReview(
      int id, Users user, String text, double rating) async {
    try {
      final token = await getToken();
      final headers = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      };
      final response =
          await http.post(Uri.parse(ApiEndpoints.postShopItemReviewUrl),
              headers: headers,
              body: jsonEncode({
                "id": "0",
                "shopItems": {"id": id},
                "users": user.toJson(),
                "reviewDescription": text,
                "reviewScore": rating
              }));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final review = GeneralReviewModel.fromJson(data);
        log(review.toString());
        return review;
      } else {
        throw Exception("Failed to add item review: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error adding item review: $e");
    }
  }
}
