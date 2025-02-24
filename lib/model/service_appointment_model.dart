import 'package:pet_care_app/model/pet_services_model.dart';

class ServiceAppointmentModel {
    ServiceAppointmentModel({
        required this.appointmentId,
        required this.usersId,
        required this.petsId,
        required this.date,
        required this.time,
        required this.status,
        required this.service,
    });

    final int? appointmentId;
    final int? usersId;
    final int? petsId;
    final DateTime? date;
    final String? time;
    final String? status;
    final PetServicesModel? service;

    factory ServiceAppointmentModel.fromJson(Map<String, dynamic> json){ 
        return ServiceAppointmentModel(
            appointmentId: json["appointmentId"],
            usersId: json["usersId"],
            petsId: json["petsId"],
            date: DateTime.tryParse(json["date"] ?? ""),
            time: json["time"],
            status: json["status"],
            service: json["service"] == null ? null : PetServicesModel.fromJson(json["service"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "appointmentId": appointmentId,
        "usersId": usersId,
        "petsId": petsId,
        "date": "${date?.year.toString().padLeft(4,'0')}-${date?.month.toString().padLeft(2,'0')}-${date?.day.toString().padLeft(2,'0')}",
        "time": "$time:00",
        "status": status,
        "service": service?.toJson(),
    };

    @override
    String toString(){
        return "$appointmentId, $usersId, $petsId, $date, $time, $status, $service, ";
    }
}