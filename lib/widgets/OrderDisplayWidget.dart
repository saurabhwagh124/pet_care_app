import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/model/orders_model.dart';
import 'package:pet_care_app/view/user_views/orders_detail_page.dart';

class OrderDisplayWidget extends StatelessWidget {
  // Assuming your 'OrdersModel' is compatible with the 'Order' class defined above.
  // If 'OrdersModel' is different, you'll need to adjust the data access (e.g., order.id)
  final OrdersModel order;

  const OrderDisplayWidget({super.key, required this.order});

  // Helper function to determine status color (from user's code)
  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'CONFIRMED':
        return Colors.green;
      case 'PENDING':
        return Colors.orange;
      case 'CANCELLED':
        return Colors.red;
      default:
        return Colors.grey; // Default color
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => OrdersDetailPage(
              order: order,
            ));
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)), // Added shape
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Order ID
              Text(
                'Order ID: ${order.id}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              /// Status Chip (from user's code)
              Row(
                children: [
                  const Text(
                    'Status: ',
                    style: TextStyle(fontSize: 16),
                  ),
                  Chip(
                    label: Text(
                      order.status!.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    backgroundColor: _getStatusColor(order.status!),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 2), // Adjust padding
                    labelPadding: EdgeInsets
                        .zero, // Remove default label padding if needed
                  ),
                ],
              ),

              const SizedBox(height: 16),

              /// Items Title
              Wrap(
                children: [
                  const Text(
                    'Remarks: ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    order.remarks.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              const SizedBox(height: 16),

              /// Total Price
              Align(
                // Align total price to the right
                alignment: Alignment.centerRight,
                child: Text(
                  // Use ?? 0.0 for null safety
                  'Total Price: ₹${(order.totalPrice ?? 0.0).toStringAsFixed(2)}', // Use Indian Rupee symbol
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
