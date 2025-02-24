import 'package:pet_care_app/model/boarding_model.dart';

class BoardingAppointmentModel {
    BoardingAppointmentModel({
        required this.appointmentId,
        required this.usersId,
        required this.petsId,
        required this.date,
        required this.time,
        required this.status,
        required this.boarding,
    });

    final int? appointmentId;
    final int? usersId;
    final int? petsId;
    final DateTime? date;
    final String? time;
    final String? status;
    final BoardingModel? boarding;

    factory BoardingAppointmentModel.fromJson(Map<String, dynamic> json){ 
        return BoardingAppointmentModel(
            appointmentId: json["appointmentId"],
            usersId: json["usersId"],
            petsId: json["petsId"],
            date: DateTime.tryParse(json["date"] ?? ""),
            time: json["time"],
            status: json["status"],
            boarding: json["boarding"] == null ? null : BoardingModel.fromJson(json["boarding"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "appointmentId": appointmentId,
        "usersId": usersId,
        "petsId": petsId,
        "date": "${date?.year.toString().padLeft(4,'0')}-${date?.month.toString().padLeft(2,'0')}-${date?.day.toString().padLeft(2,'0')}",
        "time": "$time:00",
        "status": status,
        "boarding": boarding?.toJson(),
    };

    @override
    String toString(){
        return "$appointmentId, $usersId, $petsId, $date, $time, $status, $boarding, ";
    }
}