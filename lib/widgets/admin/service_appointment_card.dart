import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Ensure these paths are correct for your project
import 'package:pet_care_app/model/service_appointment_model.dart';
import 'package:pet_care_app/model/pet_services_model.dart';

class ServiceAppointmentCard extends StatelessWidget {
  final ServiceAppointmentModel appointment;
  final VoidCallback onApprove;
  final VoidCallback onCancel;

  const ServiceAppointmentCard({
    super.key,
    required this.appointment,
    required this.onApprove,
    required this.onCancel,
  });

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    try {
      // Corrected date format
      return DateFormat('EEE, MMM d, yyyy').format(date);
    } catch (e) {
      print('Error formatting date: $e');
      return 'Invalid Date';
    }
  }

  Color _getStatusColor(String? status) {
    switch (status?.toUpperCase()) {
      case 'APPROVED':
        return Colors.green.shade700;
      case 'CANCELLED':
      case 'CANCELED':
        return Colors.red.shade700;
      case 'PENDING':
        return Colors.orange.shade700;
      default:
        return Colors.grey.shade600;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isPending = appointment.status?.toUpperCase() == 'PENDING';
    final String displayStatus = appointment.status?.toUpperCase() ?? 'UNKNOWN';
    final Color statusColor = _getStatusColor(appointment.status);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Service Appointment #${appointment.appointmentId ?? 'N/A'}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Text(
                    displayStatus,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 20.0),
            _buildInfoRow(
              Icons.calendar_today_outlined,
              'Date:',
              _formatDate(appointment.date),
            ),
            _buildInfoRow(
              Icons.access_time_outlined,
              'Time:',
              appointment.time ?? 'N/A',
            ),
            // Display Service Info if available
            if (appointment.service != null)
              _buildInfoRow(
                Icons.miscellaneous_services_outlined, // Icon for service
                'Service:',
                // Assuming PetServicesModel has a 'name' property
                '${appointment.service?.name ?? 'Details N/A'}',
              ),
            // Conditionally display buttons if pending
            if (isPending) ...[
              const SizedBox(height: 16.0),
              const Divider(height: 1.0),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    icon: const Icon(Icons.cancel_outlined, size: 18),
                    label: const Text('Cancel'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red.shade700,
                    ),
                    onPressed: onCancel,
                  ),
                  const SizedBox(width: 8.0),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.check_circle_outline, size: 18),
                    label: const Text('Approve'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green.shade600,
                    ),
                    onPressed: onApprove,
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  // Reusable helper widget for info rows
  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18.0, color: Colors.grey.shade700),
          const SizedBox(width: 8.0),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(width: 5.0),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: Colors.grey.shade800),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
