class BoardingModel {
  BoardingModel({
    required this.id,
    required this.name,
    required this.email,
    required this.contact,
    required this.address,
    required this.fees,
    required this.startDay,
    required this.endDay,
    required this.reviewScore,
    required this.noOfReviews,
    required this.startTime,
    required this.closeTime,
    required this.photoUrls,
    required this.createdAt,
  });

  final int? id;
  final String? name;
  final String? email;
  final String? contact;
  final String? address;
  final int? fees;
  final String? startDay;
  final String? endDay;
  final double? reviewScore;
  final int? noOfReviews;
  final String? startTime;
  final String? closeTime;
  final List<String> photoUrls;
  final DateTime? createdAt;

  factory BoardingModel.fromJson(Map<String, dynamic> json) {
    return BoardingModel(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      contact: json["contact"],
      address: json["address"],
      fees: json["fees"],
      startDay: json["startDay"],
      endDay: json["endDay"],
      reviewScore: json["reviewScore"],
      noOfReviews: json["noOfReviews"],
      startTime: json["startTime"],
      closeTime: json["closeTime"],
      photoUrls: json["photoUrls"] == null ? [] : List<String>.from(json["photoUrls"]!.map((x) => x)),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "contact": contact,
        "address": address,
        "fees": fees,
        "startDay": startDay,
        "endDay": endDay,
        "reviewScore": reviewScore,
        "noOfReviews": noOfReviews,
        "startTime": startTime,
        "closeTime": closeTime,
        "photoUrls": photoUrls.map((x) => x).toList(),
        "createdAt": createdAt?.toIso8601String(),
      };

  @override
  String toString() {
    return "$id, $name, $email, $contact, $address, $fees, $startDay, $endDay, $reviewScore, $noOfReviews, $startTime, $closeTime, $photoUrls, $createdAt, ";
  }
}
