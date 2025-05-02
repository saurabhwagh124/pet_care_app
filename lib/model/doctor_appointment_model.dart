import 'package:pet_care_app/model/user_pet_model.dart';
import 'package:pet_care_app/model/users.dart';
import 'package:pet_care_app/model/vet_doc_model.dart';

class DoctorAppointmentModel {
  DoctorAppointmentModel({
    required this.appointmentId,
    required this.users,
    required this.pet,
    required this.date,
    required this.time,
    required this.status,
    required this.doctor,
  });

  final int? appointmentId;
  final Users? users;
  final UserPetModel? pet;
  final DateTime? date;
  final String? time;
  final String? status;
  final VetDocModel? doctor;

  factory DoctorAppointmentModel.fromJson(Map<String, dynamic> json) {
    return DoctorAppointmentModel(
      appointmentId: json["appointmentId"],
      users: json["users"] == null ? null : Users.fromJson(json["users"]),
      pet: json["pet"] == null ? null : UserPetModel.fromJson(json["pet"]),
      date: DateTime.tryParse(json["date"] ?? ""),
      time: json["time"],
      status: json["status"],
      doctor:
          json["doctor"] == null ? null : VetDocModel.fromJson(json["doctor"]),
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
        "doctor": doctor?.toJson(),
      };

  @override
  String toString() {
    return "$appointmentId, $users, $pet, $date, $time, $status, $doctor, ";
  }
}
