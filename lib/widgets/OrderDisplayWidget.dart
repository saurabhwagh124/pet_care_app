import 'package:flutter/material.dart';
import 'package:pet_care_app/model/orders_model.dart';

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
    return Card(
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
                  labelPadding:
                      EdgeInsets.zero, // Remove default label padding if needed
                ),
              ],
            ),

            const SizedBox(height: 16),

            /// Items Title
            const Text(
              'Order Items:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 8),

            /// Items List (Modified to show itemName)
            // Use LayoutBuilder or constrain height appropriately if content might overflow
            ListView.builder(
              shrinkWrap: true, // Important when inside a Column
              physics:
                  const NeverScrollableScrollPhysics(), // Disable scrolling if inside another scrollable
              itemCount: order.orderItemsList.length,
              itemBuilder: (context, index) {
                final item = order.orderItemsList[index];
                // Use ?? 0 for null safety as in user's code
                final quantity = item.quantity ?? 0;
                final price = item.pricePerItem ?? 0.0;
                final total = quantity * price;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Display Item Name instead of ID
                      Expanded(
                        // Use Expanded to prevent overflow if name is long
                        flex: 2, // Give more space to name
                        child: Text(
                          item.id.toString(), // Display the item name here
                          style: const TextStyle(fontSize: 14),
                          overflow: TextOverflow.ellipsis, // Handle long names
                        ),
                      ),
                      Expanded(
                        // Use Expanded for consistent spacing
                        flex: 2,
                        child: Text(
                          'Qty: $quantity x ₹${price.toStringAsFixed(2)}', // Use Indian Rupee symbol
                          style: const TextStyle(fontSize: 14),
                          textAlign: TextAlign.center, // Center align
                        ),
                      ),
                      Expanded(
                        // Use Expanded
                        flex: 1,
                        child: Text(
                          '₹${total.toStringAsFixed(2)}', // Use Indian Rupee symbol
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.right, // Right align total
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

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
    );
  }
}
