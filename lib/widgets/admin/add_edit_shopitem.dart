import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/controller/shop_controller.dart';
import 'package:pet_care_app/model/shopitem_model.dart';
import 'package:pet_care_app/utils/add_pet_vaildator.dart';

class AddUpdateItemView extends StatelessWidget {
  final ShopItem? item;
  final int? index;
  final ShopController shopController = Get.find();
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final TextEditingController photoUrlController = TextEditingController();

  AddUpdateItemView({super.key, this.item, this.index}) {
    if (item != null) {
      nameController.text = item!.itemName;
      descriptionController.text = item!.description;
      priceController.text = item!.price.toString();
      discountController.text = item!.discount.toString();
      photoUrlController.text = item!.photoUrl;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item == null ? "Add Item" : "Update Item")),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                  validator: (value) =>
                      Validation.validateText(value, "Item Name"),
                  controller: nameController,
                  decoration: const InputDecoration(labelText: "Item Name")),
              TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: "Description")),
              TextFormField(
                  validator: (value) =>
                      Validation.validateNumber(value, "Price"),
                  controller: priceController,
                  decoration: const InputDecoration(labelText: "Price"),
                  keyboardType: TextInputType.number),
              TextFormField(
                  validator: (value) =>
                      Validation.validateNumber(value, "Discount"),
                  controller: discountController,
                  decoration: const InputDecoration(labelText: "Discount"),
                  keyboardType: TextInputType.number),
              TextFormField(
                  controller: photoUrlController,
                  decoration: const InputDecoration(labelText: "Photo URL")),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    double price = double.parse(priceController.text);
                    double discount = double.parse(discountController.text);
                    double discountedPrice = price - (price * discount / 100);

                    ShopItem newItem = ShopItem(
                      itemName: nameController.text,
                      description: descriptionController.text,
                      brand: "Brand Name",
                      category: "Category",
                      recommendedFor: "Dogs",
                      reviewScore: 4.8,
                      noOfReviews: 130,
                      price: price,
                      photoUrl: photoUrlController.text,
                      discount: discount,
                      discountedPrice: discountedPrice,
                    );

                    // if (item == null) {
                    //   shopController.addItem(newItem);
                    // } else {
                    //   shopController.updateItem(index!, newItem);
                    // }

                    Get.back();
                  }
                },
                child: Text(item == null ? "Add Item" : "Update Item"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
