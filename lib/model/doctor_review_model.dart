import 'package:pet_care_app/model/users.dart';
import 'package:pet_care_app/model/vet_doc_model.dart';

class DoctorReviewModel {
  DoctorReviewModel({
    required this.id,
    required this.doctor,
    required this.users,
    required this.reviewDescription,
    required this.reviewScore,
    required this.createdAt,
  });

  final int? id;
  final VetDocModel? doctor;
  final Users? users;
  final String? reviewDescription;
  final int? reviewScore;
  final DateTime? createdAt;

  factory DoctorReviewModel.fromJson(Map<String, dynamic> json) {
    return DoctorReviewModel(
        id: json["id"],
        doctor: json["doctor"] == null
            ? null
            : VetDocModel.fromJson(json["doctor"]),
        users: json["users"] == null ? null : Users.fromJson(json["users"]),
        reviewDescription: json["reviewDescription"],
        reviewScore: json["reviewScore"],
        createdAt: DateTime.parse(json["createdAt"]));
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "doctor": doctor?.toJson(),
        "users": users?.toJson(),
        "reviewDescription": reviewDescription,
        "reviewScore": reviewScore,
      };

  @override
  String toString() {
    return "$id, $doctor, $users, $reviewDescription, $reviewScore, $createdAt";
  }
}
