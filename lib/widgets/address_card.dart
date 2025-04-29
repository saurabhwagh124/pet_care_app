import 'package:flutter/material.dart';
import 'package:pet_care_app/model/address_model.dart';

class AddressCard extends StatelessWidget {
  final AddressModel address;
  final VoidCallback onDelete;

  const AddressCard({
    super.key,
    required this.address,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRow("Street", address.street),
                  _buildRow("City", address.city),
                  _buildRow("State", address.state),
                  _buildRow("Postal Code", address.postalCode),
                  _buildRow("Country", address.country),
                  // _buildRow("User Email", address.userEmail),
                ],
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => _confirmDelete(context),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(value ?? "N/A"),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete Address"),
        content: const Text("Are you sure you want to delete this address?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onDelete();
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
