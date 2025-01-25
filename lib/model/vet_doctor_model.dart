class VetDoctorModel {
  final String name;
  final String profileImg;
  final String degree;
  final int yearsOfExp;
  final double reviewStars;
  final int numberOfReview;
  final double distance;
  final int fees;
  final String startDay;
  final String endDay;
  final double startTime;
  final double endTime;
  VetDoctorModel(
      {required this.name,
      required this.profileImg,
      required this.degree,
      required this.yearsOfExp,
      required this.distance,
      required this.startDay,
      required this.endDay,
      required this.reviewStars,
      required this.numberOfReview,
      required this.fees,
      required this.startTime,
      required this.endTime});
}
