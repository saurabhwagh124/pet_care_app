import 'package:pet_care_app/model/vet_doc_model.dart';

class DoctorAppointmentModel {
    DoctorAppointmentModel({
        required this.appointmentId,
        required this.usersId,
        required this.petsId,
        required this.date,
        required this.time,
        required this.status,
        required this.doctor,
    });

    final int? appointmentId;
    final int? usersId;
    final int? petsId;
    final DateTime? date;
    final String? time;
    final String? status;
    final VetDocModel? doctor;

    factory DoctorAppointmentModel.fromJson(Map<String, dynamic> json){ 
        return DoctorAppointmentModel(
            appointmentId: json["appointmentId"],
            usersId: json["usersId"],
            petsId: json["petsId"],
            date: DateTime.tryParse(json["date"] ?? ""),
            time: json["time"],
            status: json["status"],
            doctor: json["doctor"] == null ? null : VetDocModel.fromJson(json["doctor"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "appointmentId": appointmentId,
        "usersId": usersId,
        "petsId": petsId,
        "date": "${date?.year.toString().padLeft(4,'0')}-${date?.month.toString().padLeft(2,'0')}-${date?.day.toString().padLeft(2,'0')}",
        "time": "$time:00",
        "status": status,
        "doctor": doctor?.toJson(),
    };

    @override
    String toString(){
        return "$appointmentId, $usersId, $petsId, $date, $time, $status, $doctor, ";
    }
}