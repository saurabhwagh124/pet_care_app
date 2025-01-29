class VetDocModel {
  VetDocModel({
    required this.id,
    required this.email,
    required this.name,
    required this.specialization,
    required this.experienceYears,
    required this.photoUrl,
    required this.address,
    required this.fees,
    required this.startDay,
    required this.endDay,
    required this.reviewScore,
    required this.noOfReviews,
    required this.startTime,
    required this.closeTime,
    required this.description,
    required this.clinicName,
  });

  final int? id;
  final String? email;
  final String? name;
  final String? specialization;
  final int? experienceYears;
  final String? photoUrl;
  final String? address;
  final int? fees;
  final String? startDay;
  final String? endDay;
  final double? reviewScore;
  final int? noOfReviews;
  final String? startTime;
  final String? closeTime;
  final String? description;
  final String? clinicName;

  factory VetDocModel.fromJson(Map<String, dynamic> json) {
    return VetDocModel(
      id: json["id"],
      email: json["email"],
      name: json["name"],
      specialization: json["specialization"],
      experienceYears: json["experienceYears"],
      photoUrl: json["photoUrl"],
      address: json["address"],
      fees: json["fees"],
      startDay: json["startDay"],
      endDay: json["endDay"],
      reviewScore: json["reviewScore"],
      noOfReviews: json["noOfReviews"],
      startTime: json["startTime"],
      closeTime: json["closeTime"],
      description: json["description"],
      clinicName: json["clinicName"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "name": name,
        "specialization": specialization,
        "experienceYears": experienceYears,
        "photoUrl": photoUrl,
        "address": address,
        "fees": fees,
        "startDay": startDay,
        "endDay": endDay,
        "reviewScore": reviewScore,
        "noOfReviews": noOfReviews,
        "startTime": startTime,
        "closeTime": closeTime,
        "description": description,
        "clinicName": clinicName,
      };

  @override
  String toString() {
    return "$id, $email, $name, $specialization, $experienceYears, $photoUrl, $address, $fees, $startDay, $endDay, $reviewScore, $noOfReviews, $startTime, $closeTime, $description, $clinicName, ";
  }
}
