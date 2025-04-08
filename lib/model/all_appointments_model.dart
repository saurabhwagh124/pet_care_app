import 'package:pet_care_app/model/boarding_appointment_model.dart';
import 'package:pet_care_app/model/doctor_appointment_model.dart';
import 'package:pet_care_app/model/service_appointment_model.dart';

class AllAppointmentsModel {
    AllAppointmentsModel({
        required this.doctor,
        required this.boarding,
        required this.service,
    });

    final List<DoctorAppointmentModel> doctor;
    final List<BoardingAppointmentModel> boarding;
    final List<ServiceAppointmentModel> service;

    factory AllAppointmentsModel.fromJson(Map<String, dynamic> json) {
        return AllAppointmentsModel(
            doctor: (json["doctor"] as List<dynamic>?)?.map((x) => DoctorAppointmentModel.fromJson(x)).toList() ?? [],
            boarding: (json["boarding"] as List<dynamic>?)?.map((x) => BoardingAppointmentModel.fromJson(x)).toList() ?? [],
            service: (json["service"] as List<dynamic>?)?.map((x) => ServiceAppointmentModel.fromJson(x)).toList() ?? [],
        );
    }

    Map<String, dynamic> toJson() => {
        "doctor": doctor.map((x) => x.toJson()).toList(),
        "boarding": boarding.map((x) => x.toJson()).toList(),
        "service": service.map((x) => x.toJson()).toList(),
    };

    @override
    String toString() {
        return "AllAppointmentsModel(\n"
               "  doctor: $doctor,\n"
               "  boarding: $boarding,\n"
               "  service: $service\n"
               ")";
    }

    AllAppointmentsModel copyWith({
        List<DoctorAppointmentModel>? doctor,
        List<BoardingAppointmentModel>? boarding,
        List<ServiceAppointmentModel>? service,
    }) {
        return AllAppointmentsModel(
            doctor: doctor ?? this.doctor,
            boarding: boarding ?? this.boarding,
            service: service ?? this.service,
        );
    }
}
