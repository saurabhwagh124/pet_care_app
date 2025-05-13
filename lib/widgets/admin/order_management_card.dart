import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pet_care_app/controller/orders_controller.dart';
import 'package:pet_care_app/model/orders_model.dart';

class OrderManagementCard extends StatefulWidget {
  final OrdersModel order;
  final int index;

  const OrderManagementCard({
    super.key,
    required this.order,
    required this.index,
  });

  @override
  State createState() => _OrderManagementCardState();
}

class _OrderManagementCardState extends State<OrderManagementCard> {
  late OrderStatus _selectedStatus;
  late TextEditingController _remarksController;
  final controller = Get.find<OrdersController>();
  final _formKey = GlobalKey<FormState>();

  // Helper to convert OrderStatus enum to String
  String _statusToString(OrderStatus status) {
    return status.toString().split('.').last;
  }

  // Helper to convert String to OrderStatus enum
  OrderStatus _stringToStatus(String? statusString) {
    if (statusString == null) return OrderStatus.PENDING; // Default
    return OrderStatus.values.firstWhere(
        (e) => e.toString().split('.').last == statusString,
        orElse: () => OrderStatus.PENDING // Default if not found
        );
  }

  @override
  void initState() {
    super.initState();
    _selectedStatus = _stringToStatus(widget.order.status);
    _remarksController =
        TextEditingController(text: widget.order.remarks ?? '');
  }

  @override
  void dispose() {
    _remarksController.dispose();
    super.dispose();
  }

  void _handleUpdate() {
    if (_formKey.currentState!.validate()) {
      // Create a new OrdersModel instance with updated values
      // This is good practice for immutability if your parent widget expects a new instance.
      // Alternatively, you can directly modify widget.order if it's designed to be mutable
      // and your state management allows it.
      final updatedOrder = OrdersModel(
        id: widget.order.id,
        usersId: widget.order.usersId,
        orderItemsList: widget.order.orderItemsList,
        totalPrice: widget.order.totalPrice,
        address: widget.order.address,
        remarks: _remarksController.text.trim(),
        status: _statusToString(_selectedStatus),
        createdAt: widget.order.createdAt,
      );
      controller.updateOrder(updatedOrder, widget.index);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Order ID ${widget.order.id} updated'),
          backgroundColor: Colors.orangeAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Order ID: ${widget.order.id ?? 'N/A'}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 8.0),
              if (widget.order.createdAt != null)
                Text(
                  'Created: ${DateFormat.yMMMd().add_jm().format(widget.order.createdAt!)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              const SizedBox(height: 8.0),
              Text('User ID: ${widget.order.usersId ?? 'N/A'}'),
              Text(
                  'Total Price: \$${(widget.order.totalPrice ?? 0) / 100.0}'), // Assuming price is in cents
              if (widget.order.address != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text('Address: ${widget.order.address.toString()}'),
                ),
              const SizedBox(height: 16.0),
              Text(
                'Order Items (${widget.order.orderItemsList.length}):',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              if (widget.order.orderItemsList.isNotEmpty)
                SizedBox(
                  height: 50, // Constrain height for item list
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.order.orderItemsList.length,
                    itemBuilder: (context, index) {
                      final item = widget.order.orderItemsList[index];
                      return Text(
                          '- Item ID: ${item.itemId}, Qty: ${item.quantity}, Price: \$${(item.pricePerItem ?? 0) / 100.0}');
                    },
                  ),
                ),
              if (widget.order.orderItemsList.isEmpty)
                const Text('No items in this order.'),
              const Divider(height: 32.0),

              // Status Dropdown
              DropdownButtonFormField<OrderStatus>(
                decoration: InputDecoration(
                  labelText: 'Order Status',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
                value: _selectedStatus,
                items: OrderStatus.values.map((OrderStatus status) {
                  return DropdownMenuItem<OrderStatus>(
                    value: status,
                    child: Text(
                      _statusToString(status),
                      style: const TextStyle(fontSize: 15),
                    ),
                  );
                }).toList(),
                onChanged: (OrderStatus? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedStatus = newValue;
                    });
                  }
                },
                validator: (value) =>
                    value == null ? 'Please select a status' : null,
              ),
              const SizedBox(height: 16.0),

              // Remarks TextField
              TextFormField(
                controller: _remarksController,
                decoration: InputDecoration(
                  labelText: 'Remarks',
                  hintText: 'Add any remarks for this order...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
                maxLines: 3,
                onChanged: (value) {
                  // You can update a local variable here if you don't want to wait for the button press
                  // For instance, if you want to auto-save or have more reactive behavior.
                },
              ),
              const SizedBox(height: 24.0),

              Center(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.update),
                  label: const Text('Update Order Details'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 12.0),
                    textStyle: const TextStyle(fontSize: 16),
                    // backgroundColor: Theme.of(context).primaryColor, // Use primary color from theme
                    // foregroundColor: Colors.white,
                  ),
                  onPressed: _handleUpdate,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum OrderStatus { PENDING, SHIPPED, DELIVERED, CANCELLED }
