class ApiEndpoints {
  static String baseUrl =
      "http://petcarebackend1-env.eba-pkcec8a7.ap-south-1.elasticbeanstalk.com:5000";

  // static String baseUrl = "https://pet-care-server-jar-v8.onrender.com/public";
  // static String baseUrl = "http://10.144.85.22:5000";
  static String loginUrl = "$baseUrl/login";
  static String registerUrl = "$baseUrl/register";

  // ALL Get
  static String getAllDoctorsUrl = "$baseUrl/doctors";
  static String getAllBoardingsUrl = "$baseUrl/boarding";
  static String getAllPetServicesUrl = "$baseUrl/pet-service";
  static String getAllPetsOfUserUrl = "$baseUrl/pet/users/{userEmail}";
  static String getAllShopItemUrl = "$baseUrl/shopItem/";
  static String getAllAppointmentsUrl = "$baseUrl/appointments/{id}";
  static String checkAdminUrl = "$baseUrl/admin-access?email={MAIL}";
  static String getUserDataUrl = "$baseUrl/users?email={MAIL}";
  static String getDoctorAppointmentsSlotsUrl =
      "$baseUrl/appointments/doctor/{id}/timeslots/{date}";
  static String getBoardingAppointmentsSlotsUrl =
      "$baseUrl/appointments/boarding/{id}/timeslots/{date}";
  static String getServiceAppointmentsSlotsUrl =
      "$baseUrl/appointments/service/{id}/timeslots/{date}";
  static String getDoctorReviewsUrl = "$baseUrl/reviews/doctor/{id}";
  static String getBoardingReviewsUrl = "$baseUrl/reviews/boarding/{id}";
  static String getServiceReviewsUrl = "$baseUrl/reviews/service/{id}";
  static String getAddressUrl = "$baseUrl/users/{email}/address";
  static String getOrdersByUserUrl = "$baseUrl/orders/{id}";
  static String getBoardingAppointmentsUrl =
      "$baseUrl/appointments/boarding/{id}";
  static String getDoctorAppointmentsUrl = "$baseUrl/appointments/doctors/{id}";
  static String getServiceAppointmentsUrl =
      "$baseUrl/appointments/service/{id}";
  static String getOrderItemsUrl = "$baseUrl/shopItemsList";

  // ALL Post
  static String postUserPetUrl = "$baseUrl/pet";
  static String postUploadFileUrl = "$baseUrl/public/upload-file";
  static String postUploadMultipleFilesUrl =
      "$baseUrl/public/upload-multiple-files";
  static String postDoctorAppointmentUrl = "$baseUrl/appointments/doctors";
  static String postBoardingAppointmentUrl = "$baseUrl/appointments/boarding";
  static String postServiceAppointmentUrl = "$baseUrl/appointments/service";
  static String postDoctorReviewUrl = "$baseUrl/reviews/doctor";
  static String postBoardingReviewUrl = "$baseUrl/reviews/boarding";
  static String postServiceReviewUrl = "$baseUrl/reviews/service";
  static String postShopItemReviewUrl = "$baseUrl/reviews/items";
  static String postFcmTokenUrl =
      "$baseUrl/users/{EMAIL}/fcm-token?fcm={TOKEN}";
  static String postNotificationToAll = "$baseUrl/notification/all";
  static String postAddAddressUrl = "$baseUrl/users/address";
  static String postAddOrderUrl = "$baseUrl/orders/add";
  static String postBoardingConfirmUrl =
      "$baseUrl/appointments/boarding/{id}/confirm";
  static String postDoctorConfirmUrl =
      "$baseUrl/appointments/doctor/{id}/confirm";
  static String postServicesConfirmUrl =
      "$baseUrl/appointments/service/{id}/confirm";
  static String postBoardingCancelUrl =
      "$baseUrl/appointments/boarding/{id}/cancel";
  static String postDoctorCancelUrl =
      "$baseUrl/appointments/doctor/{id}/cancel";
  static String postServicesCancelUrl =
      "$baseUrl/appointments/service/{id}/cancel";

  //Put
  static String putOrderEditUrl = "$baseUrl/orders/edit";
  static String putUserEditUrl = "$baseUrl/users/edit";

  static String deleteAddressUrl = "$baseUrl/users/address/{id}";

  static String getAllOrdersUrl = "$baseUrl/orders";

  // DELETE
  static String deleteUserPetUrl = "$baseUrl/pet/{id}";

  static String postAddProductUrl = "$baseUrl/shopItem";

  static var deleteItemUrl = "$baseUrl/shopItem/{id}";
}
