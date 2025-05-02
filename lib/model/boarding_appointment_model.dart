import 'package:pet_care_app/model/boarding_model.dart';
import 'package:pet_care_app/model/user_pet_model.dart';
import 'package:pet_care_app/model/users.dart';

class BoardingAppointmentModel {
  BoardingAppointmentModel({
    required this.appointmentId,
    required this.users,
    required this.pet,
    required this.date,
    required this.time,
    required this.status,
    required this.boarding,
  });

  final int? appointmentId;
  final Users? users;
  final UserPetModel? pet;
  final DateTime? date;
  final String? time;
  final String? status;
  final BoardingModel? boarding;

  factory BoardingAppointmentModel.fromJson(Map<String, dynamic> json) {
    return BoardingAppointmentModel(
      appointmentId: json["appointmentId"],
      users: json["users"] == null ? null : Users.fromJson(json["users"]),
      pet: json["pet"] == null ? null : UserPetModel.fromJson(json["pet"]),
      date: DateTime.tryParse(json["date"] ?? ""),
      time: json["time"],
      status: json["status"],
      boarding: json["boarding"] == null
          ? null
          : BoardingModel.fromJson(json["boarding"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "appointmentId": appointmentId,
        "usersId": users?.toJson(),
        "petsId": pet?.toJson(),
        "date":
            "${date?.year.toString().padLeft(4, '0')}-${date?.month.toString().padLeft(2, '0')}-${date?.day.toString().padLeft(2, '0')}",
        "time": "$time:00",
        "status": status,
        "boarding": boarding?.toJson(),
      };

  @override
  String toString() {
    return "$appointmentId, $users, $pet, $date, $time, $status, $boarding, ";
  }
}

//PENDING
