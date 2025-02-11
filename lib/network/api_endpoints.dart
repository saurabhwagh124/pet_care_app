class ApiEndpoints {
  static String baseUrl = "http://192.168.0.107:5000/public";
  static String loginUrl = "$baseUrl/login";
  static String registerUrl = "$baseUrl/register";
  static String getAllDoctorsUrl = "$baseUrl/doctors";
  static String getAllBoardingsUrl = "$baseUrl/boarding";
  static String getAllPetServicesUrl = "$baseUrl/pet-service";
  static String getAllPetsOfUserUrl = "$baseUrl/users/{userEmail}/pets";
  static String postUploadFileUrl = "$baseUrl/upload-file";
  static String postUploadMultipleFilesUrl = "$baseUrl/upload-multiple-files";
}
