import 'package:pet_care_app/model/pet_services_model.dart';
import 'package:pet_care_app/model/user.dart';

class ServiceReviewModel {
    ServiceReviewModel({
        required this.id,
        required this.petServices,
        required this.users,
        required this.reviewDescription,
        required this.reviewScore,
        required this.createdAt,
    });

    final int? id;
    final PetServicesModel? petServices;
    final User? users;
    final String? reviewDescription;
    final int? reviewScore;
    final DateTime? createdAt;

    factory ServiceReviewModel.fromJson(Map<String, dynamic> json){ 
        return ServiceReviewModel(
            id: json["id"],
            petServices: json["petServices"] == null ? null : PetServicesModel.fromJson(json["petServices"]),
            users: json["users"] == null ? null : User.fromJson(json["users"]),
            reviewDescription: json["reviewDescription"],
            reviewScore: json["reviewScore"],
            createdAt: DateTime.parse(json["createdAt"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "petServices": petServices?.toJson(),
        "users": users?.toJson(),
        "reviewDescription": reviewDescription,
        "reviewScore": reviewScore,
    };

    @override
    String toString(){
        return "$id, $petServices, $users, $reviewDescription, $reviewScore, $createdAt";
    }
}