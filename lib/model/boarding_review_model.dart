import 'package:pet_care_app/model/boarding_model.dart';
import 'package:pet_care_app/model/users.dart';

class BoardingReviewModel {
  BoardingReviewModel(
      {required this.id,
      required this.boarding,
      required this.users,
      required this.reviewDescription,
      required this.reviewScore,
      required this.createdAt});

  final int? id;
  final BoardingModel? boarding;
  final Users? users;
  final String? reviewDescription;
  final int? reviewScore;
  final DateTime? createdAt;

  factory BoardingReviewModel.fromJson(Map<String, dynamic> json) {
    return BoardingReviewModel(
        id: json["id"],
        boarding: json["boarding"] == null
            ? null
            : BoardingModel.fromJson(json["boarding"]),
        users: json["users"] == null ? null : Users.fromJson(json["users"]),
        reviewDescription: json["reviewDescription"],
        reviewScore: json["reviewScore"],
        createdAt: DateTime.parse(json["createdAt"]));
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "boarding": boarding?.toJson(),
        "users": users?.toJson(),
        "reviewDescription": reviewDescription,
        "reviewScore": reviewScore,
      };

  @override
  String toString() {
    return "$id, $boarding, $users, $reviewDescription, $reviewScore, $createdAt";
  }
}
