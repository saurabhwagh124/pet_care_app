import 'package:pet_care_app/model/user.dart';

class GeneralReviewModel {
    GeneralReviewModel({
        required this.id,
        required this.users,
        required this.reviewDescription,
        required this.reviewScore,
        required this.createdAt,
    });

    final int? id;
    final User? users;
    final String? reviewDescription;
    final double? reviewScore;
    final DateTime? createdAt;

    factory GeneralReviewModel.fromJson(Map<String, dynamic> json){ 
        return GeneralReviewModel(
            id: json["id"],
            users: json["users"] == null ? null : User.fromJson(json["users"]),
            reviewDescription: json["reviewDescription"],
            reviewScore: json["reviewScore"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "users": users?.toJson(),
        "reviewDescription": reviewDescription,
        "reviewScore": reviewScore,
        "createdAt": createdAt?.toIso8601String(),
    };

    @override
    String toString(){
        return "$id, $users, $reviewDescription, $reviewScore, $createdAt, ";
    }
}

