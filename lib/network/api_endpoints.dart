class ApiEndpoints {
  static String baseUrl = "http://petcarebackend1-env.eba-pkcec8a7.ap-south-1.elasticbeanstalk.com:5000/public";
  static String loginUrl = "$baseUrl/login";
  static String registerUrl = "$baseUrl/register";
  static String getAllDoctorsUrl = "$baseUrl/doctors";
  static String getAllBoardingsUrl = "$baseUrl/boarding";
  static String getAllPetServicesUrl = "$baseUrl/pet-service";
  static String getAllPetsOfUserUrl = "$baseUrl/users/{userEmail}/pets";
  static String postUploadFileUrl = "$baseUrl/upload-file";
  static String postUploadMultipleFilesUrl = "$baseUrl/upload-multiple-files";
}
