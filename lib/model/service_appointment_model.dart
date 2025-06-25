import 'package:pet_care_app/model/pet_services_model.dart';
import 'package:pet_care_app/model/user_pet_model.dart';
import 'package:pet_care_app/model/users.dart';

class ServiceAppointmentModel {
  ServiceAppointmentModel({
    required this.appointmentId,
    required this.users,
    required this.pet,
    required this.date,
    required this.time,
    required this.status,
    required this.service,
  });

  final int? appointmentId;
  final Users? users;
  final UserPetModel? pet;
  final DateTime? date;
  final String? time;
  final String? status;
  final PetServicesModel? service;

  factory ServiceAppointmentModel.fromJson(Map<String, dynamic> json) {
    return ServiceAppointmentModel(
      appointmentId: json["appointmentId"],
      users: json["users"] == null ? null : Users.fromJson(json["users"]),
      pet: json["pet"] == null ? null : UserPetModel.fromJson(json["pet"]),
      date: DateTime.tryParse(json["date"] ?? ""),
      time: json["time"],
      status: json["status"],
      service: json["service"] == null
          ? null
          : PetServicesModel.fromJson(json["service"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "appointmentId": appointmentId,
        "users": users?.toJson(),
        "pet": pet?.toJson(),
        "date":
            "${date?.year.toString().padLeft(4, '0')}-${date?.month.toString().padLeft(2, '0')}-${date?.day.toString().padLeft(2, '0')}",
        "time": "$time:00",
        "status": status,
        "service": service?.toJson(),
      };

  @override
  String toString() {
    return "$appointmentId, $users, $pet, $date, $time, $status, $service, ";
  }
}
