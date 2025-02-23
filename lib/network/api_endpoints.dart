class ApiEndpoints {
  static String baseUrl = "http://petcarebackend1-env.eba-pkcec8a7.ap-south-1.elasticbeanstalk.com:5000/public";
  // static String baseUrl = "http://192.168.0.107:5000/public";
  static String loginUrl = "$baseUrl/login";
  static String registerUrl = "$baseUrl/register";
  static String getAllDoctorsUrl = "$baseUrl/doctors";
  static String getAllBoardingsUrl = "$baseUrl/boarding";
  static String getAllPetServicesUrl = "$baseUrl/pet-service";
  static String getAllPetsOfUserUrl = "$baseUrl/users/{userEmail}/pets";
  static String postUserPetUrl = "$baseUrl/pet";
  static String postUploadFileUrl = "$baseUrl/upload-file";
  static String postUploadMultipleFilesUrl = "$baseUrl/upload-multiple-files";
  static String getAllShopItemUrl = "$baseUrl/shopItem-by-category/";
  static String checkAdminUrl = "$baseUrl/admin-access?email={MAIL}";
  static String getUserDataUrl = "$baseUrl/users?email={MAIL}";
}
