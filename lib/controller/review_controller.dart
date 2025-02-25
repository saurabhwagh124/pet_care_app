import 'dart:developer';

import 'package:get/get.dart';
import 'package:pet_care_app/model/general_review_model.dart';
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
      averageRating.value = (reviewsList.fold<double>(0, (previousValue, element) => previousValue + element.reviewScore!) / noOfReviews.value);
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
      averageRating.value = (reviewsList.fold<double>(0, (previousValue, element) => previousValue + element.reviewScore!) / noOfReviews.value);
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
      averageRating.value = (reviewsList.fold<double>(0, (previousValue, element) => previousValue + element.reviewScore!) / noOfReviews.value);
    } on Exception catch (e) {
      reviewApiStatus(ApiStatus.ERROR);
      log("Error fetching service reviews: $e");
    }
  }
}
