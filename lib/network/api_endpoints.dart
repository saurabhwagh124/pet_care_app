class ApiEndpoints {
  // static String baseUrl = "http://petcarebackend1-env.eba-pkcec8a7.ap-south-1.elasticbeanstalk.com:5000/public";
  static String baseUrl = "http://192.168.0.102:5000/public";
  static String loginUrl = "$baseUrl/login";
  static String registerUrl = "$baseUrl/register";

  // ALL Get
  static String getAllDoctorsUrl = "$baseUrl/doctors";
  static String getAllBoardingsUrl = "$baseUrl/boarding";
  static String getAllPetServicesUrl = "$baseUrl/pet-service";
  static String getAllPetsOfUserUrl = "$baseUrl/pet/users/{userEmail}";
  static String getAllShopItemUrl = "$baseUrl/shopItem/";
  static String getAllAppointmentsUrl = "$baseUrl/appointments/{ID}";
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

  // ALL Post
  static String postUserPetUrl = "$baseUrl/pet";
  static String postUploadFileUrl = "$baseUrl/upload-file";
  static String postUploadMultipleFilesUrl = "$baseUrl/upload-multiple-files";
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
}
