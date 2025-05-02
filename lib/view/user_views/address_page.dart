import 'package:firebase_auth/firebase_auth.dart' as FB;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/controller/user_controller.dart';
import 'package:pet_care_app/model/address_model.dart';
import 'package:pet_care_app/utils/app_colors.dart';
import 'package:pet_care_app/widgets/address_card.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final controller = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    controller.fetchUserAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 25.sp),
          onPressed: () => Get.back(),
        ),
        backgroundColor: AppColors.yellowCircle,
        centerTitle: true,
        title: const Text(
          "My Addresses",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 20.h),
        child: Obx(() => ListView.builder(
              itemBuilder: (context, index) => AddressCard(
                address: controller.addressList[index],
                onDelete: () {
                  controller.deleteUserAddress(
                      controller.addressList.elementAt(index).id ?? 0);
                  controller.addressList.removeAt(index);
                },
              ),
              itemCount: controller.addressList.length,
            )),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.orangeAccent,
        onPressed: () {
          showAddAddressBottomSheet(context: context);
        },
        label: const Text(
          "Add Address",
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  void showAddAddressBottomSheet({
    required BuildContext context,
  }) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController streetController = TextEditingController();
    final TextEditingController cityController = TextEditingController();
    final TextEditingController stateController = TextEditingController();
    final TextEditingController postalCodeController = TextEditingController();
    final TextEditingController countryController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 24,
          ),
          child: Form(
            key: formKey,
            child: Wrap(
              runSpacing: 12,
              children: [
                const Center(
                  child: Text(
                    "Add Address",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                TextFormField(
                  controller: streetController,
                  decoration: const InputDecoration(labelText: "Street"),
                  validator: (value) => value!.isEmpty ? 'Enter street' : null,
                ),
                TextFormField(
                  controller: cityController,
                  decoration: const InputDecoration(labelText: "City"),
                  validator: (value) => value!.isEmpty ? 'Enter city' : null,
                ),
                TextFormField(
                  controller: stateController,
                  decoration: const InputDecoration(labelText: "State"),
                  validator: (value) => value!.isEmpty ? 'Enter state' : null,
                ),
                TextFormField(
                  controller: postalCodeController,
                  decoration: const InputDecoration(labelText: "Postal Code"),
                  validator: (value) =>
                      value!.isEmpty ? 'Enter postal code' : null,
                ),
                TextFormField(
                  controller: countryController,
                  decoration: const InputDecoration(labelText: "Country"),
                  validator: (value) => value!.isEmpty ? 'Enter country' : null,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      final newAddress = AddressModel(
                        id: null,
                        street: streetController.text,
                        city: cityController.text,
                        state: stateController.text,
                        postalCode: postalCodeController.text,
                        country: countryController.text,
                        userEmail:
                            await FB.FirebaseAuth.instance.currentUser?.email,
                      );
                      Get.back();
                      controller.addAddress(newAddress);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Save Address"),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}
