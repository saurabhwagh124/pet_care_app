import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/controller/appointment_controller.dart';

class ConfirmedAppointmentsWidget extends StatefulWidget {
  const ConfirmedAppointmentsWidget({super.key});

  @override
  State<ConfirmedAppointmentsWidget> createState() =>
      _ConfirmedAppointmentsWidgetState();
}

class _ConfirmedAppointmentsWidgetState
    extends State<ConfirmedAppointmentsWidget> {
  final _controller = Get.find<AppointmentController>();

  @override
  void initState() {
    super.initState();
    _controller.fetchAllAppointments();
    log(_controller.allAppointments.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final confirmedDoctorAppointments = _controller.docAppointmentList
          .where((appointment) => appointment.status == 'CONFIRMED')
          .toList();

      confirmedDoctorAppointments.sort((a, b) {
        return (a.appointmentId ?? 0).compareTo(b.appointmentId ?? 0);
      });

      if (_controller.isLoading.value) {
        return const Center(
            child: CircularProgressIndicator(
          color: Colors.green,
        ));
      }

      if (confirmedDoctorAppointments.isEmpty) {
        return const Center(
          child: Text(
            "No confirmed appointments available.",
            style: TextStyle(fontSize: 16),
          ),
        );
      }

      return ListView.builder(
        itemCount: confirmedDoctorAppointments.length,
        itemBuilder: (context, index) {
          final appointment = confirmedDoctorAppointments[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 8),
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "Appointment ID: ${appointment.appointmentId ?? 'Unknown'}",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text("Doctor: ${appointment.doctor?.name ?? 'Unknown'}",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Pet: ${appointment.pet?.name ?? 'Unknown'}"),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            "CONFIRMED",
                            style: TextStyle(
                                fontSize: 10,
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Text(
                          "Date: ${appointment.date?.toLocal().toString().split(' ')[0]}",
                          style: const TextStyle(fontSize: 12),
                        ),
                        const SizedBox(width: 15),
                        Text(
                          "Time: ${appointment.time}",
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
