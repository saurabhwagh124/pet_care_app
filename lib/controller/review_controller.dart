import 'dart:developer';

import 'package:get/get.dart';
import 'package:pet_care_app/model/general_review_model.dart';
import 'package:pet_care_app/model/users.dart';
import 'package:pet_care_app/service/review_service.dart';
import 'package:pet_care_app/utils/enums.dart';

class ReviewController extends GetxController {
  ReviewService reviewService = ReviewService();
  RxList<GeneralReviewModel> reviewsList = <GeneralReviewModel>[].obs;
  var reviewApiStatus = ApiStatus.LOADING.obs;
  RxDouble averageRating = 0.0.obs;
  RxInt noOfReviews = 0.obs;

  void fetchDoctorReviews(int doctorId) async {
    try {
      reviewApiStatus(ApiStatus.LOADING);
      reviewsList.value = await reviewService.fetchDoctorReviews(doctorId);
      reviewApiStatus(ApiStatus.SUCCESS);
      noOfReviews.value = reviewsList.length;
      averageRating.value = (reviewsList.fold<double>(
              0,
              (previousValue, element) =>
                  previousValue + element.reviewScore!) /
          noOfReviews.value);
    } on Exception catch (e) {
      reviewApiStatus(ApiStatus.ERROR);
      log("Error fetching doctor reviews: $e");
    }
  }

  void fetchBoardingReviews(int boardingId) async {
    try {
      reviewApiStatus(ApiStatus.LOADING);
      reviewsList.value = await reviewService.fetchBoardingReviews(boardingId);
      reviewApiStatus(ApiStatus.SUCCESS);
      noOfReviews.value = reviewsList.length;
      averageRating.value = (reviewsList.fold<double>(
              0,
              (previousValue, element) =>
                  previousValue + element.reviewScore!) /
          noOfReviews.value);
    } on Exception catch (e) {
      reviewApiStatus(ApiStatus.ERROR);
      log("Error fetching boarding reviews: $e");
    }
  }

  void fetchServiceReviews(int serviceId) async {
    try {
      reviewApiStatus(ApiStatus.LOADING);
      reviewsList.value = await reviewService.fetchServiceReviews(serviceId);
      reviewApiStatus(ApiStatus.SUCCESS);
      noOfReviews.value = reviewsList.length;
      averageRating.value = (reviewsList.fold<double>(
              0,
              (previousValue, element) =>
                  previousValue + element.reviewScore!) /
          noOfReviews.value);
    } on Exception catch (e) {
      reviewApiStatus(ApiStatus.ERROR);
      log("Error fetching service reviews: $e");
    }
  }

  void addDoctorReview(
      int doctorId, Users user, String review, double reviewScore) async {
    try {
      reviewsList.add(await reviewService.addDoctorReview(
          doctorId, user, review, reviewScore));
      fetchDoctorReviews(doctorId);
    } on Exception catch (e) {
      log("Error adding doctor review: $e");
    }
  }

  void addBoardingReview(int id, Users user, String text, double rating) async {
    try {
      reviewsList
          .add(await reviewService.addBoardingReview(id, user, text, rating));
      fetchBoardingReviews(id);
    } catch (e) {
      throw Exception("Error adding boarding review: $e");
    }
  }

  void addServiceReview(int id, Users user, String text, double rating) async {
    try {
      reviewsList
          .add(await reviewService.addServiceReview(id, user, text, rating));
      fetchServiceReviews(id);
    } catch (e) {
      throw Exception("Error adding service review: $e");
    }
  }

  void addItemReview(int id, Users user, String text, double rating) async {
    try {
      reviewsList
          .add(await reviewService.addItemReview(id, user, text, rating));
    } catch (e) {
      throw Exception("Error adding item review: $e");
    }
  }
}
