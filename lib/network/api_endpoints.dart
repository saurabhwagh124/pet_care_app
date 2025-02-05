class ApiEndpoints {
  // static String baseUrl = "http://192.168.0.107:8888/public";
  static String baseUrl =
      "http://petcarebackend1dev-env.eba-pkcec8a7.ap-south-1.elasticbeanstalk.com:5000/public";
  static String loginUrl = "$baseUrl/login";
  static String registerUrl = "$baseUrl/register";
  static String getAllDoctorsUrl = "$baseUrl/doctors";
  static String getAllBoardingsUrl = "$baseUrl/boarding";
  static String getAllPetServicesUrl = "$baseUrl/petService";
}
