class PetServicesModel {
  PetServicesModel({
    required this.id,
    required this.email,
    required this.name,
    required this.category,
    required this.fees,
    required this.photoUrl,
    required this.reviewScore,
    required this.noOfReviews,
    required this.description,
    required this.createdAt,
    required this.open,
  });

  final int? id;
  final String? email;
  final String? name;
  final String? category;
  final int? fees;
  final List<String> photoUrl;
  final double? reviewScore;
  final int? noOfReviews;
  final String? description;
  final DateTime? createdAt;
  final bool? open;

  factory PetServicesModel.fromJson(Map<String, dynamic> json) {
    return PetServicesModel(
      id: json["id"],
      email: json["email"],
      name: json["name"],
      category: json["category"],
      fees: json["fees"],
      photoUrl: json["photoUrl"] == null ? [] : List<String>.from(json["photoUrl"]!.map((x) => x)),
      reviewScore: json["reviewScore"],
      noOfReviews: json["noOfReviews"],
      description: json["description"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      open: json["open"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "name": name,
        "category": category,
        "fees": fees,
        "photoUrl": photoUrl.map((x) => x).toList(),
        "reviewScore": reviewScore,
        "noOfReviews": noOfReviews,
        "description": description,
        "createdAt": createdAt?.toIso8601String(),
        "open": open,
      };

  @override
  String toString() {
    return "$id, $email, $name, $category, $fees, $photoUrl, $reviewScore, $noOfReviews, $description, $createdAt, $open, ";
  }
}
