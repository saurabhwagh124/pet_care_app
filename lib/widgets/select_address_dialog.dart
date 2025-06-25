import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/controller/user_controller.dart';
import 'package:pet_care_app/model/address_model.dart';

class SelectAddressDialog extends StatefulWidget {
  const SelectAddressDialog({
    super.key,
  });

  @override
  State<SelectAddressDialog> createState() => _SelectAddressDialogState();
}

class _SelectAddressDialogState extends State<SelectAddressDialog> {
  AddressModel? selectedAddress;

  late List<AddressModel> addresses;
  final userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    userController.fetchUserAddress();
    addresses = userController.addressList;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Address'),
      content: SizedBox(
        width: double.maxFinite,
        child: Obx(
          () => ListView.builder(
            shrinkWrap: true,
            itemCount: addresses.length,
            itemBuilder: (context, index) {
              final address = addresses[index];
              final isSelected = selectedAddress == address;
              return ListTile(
                title: Text("${address.street}, ${address.city}"),
                subtitle: Text("${address.state}, ${address.postalCode}"),
                leading: Radio<AddressModel>(
                  value: address,
                  groupValue: selectedAddress,
                  onChanged: (value) {
                    setState(() {
                      selectedAddress = value;
                    });
                  },
                ),
                onTap: () {
                  setState(() {
                    selectedAddress = address;
                  });
                },
              );
            },
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), // Cancel
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: selectedAddress != null
              ? () => Navigator.pop(context, selectedAddress)
              : null,
          child: const Text('Select Address'),
        ),
      ],
    );
  }
}
