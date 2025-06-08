import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_care_app/controller/shop_controller.dart';
import 'package:pet_care_app/model/product.dart'; // Ensure this path is correct and model includes quantity
import 'package:pet_care_app/service/upload_service.dart';

class ProductAddEditScreen extends StatefulWidget {
  final Product? productToEdit;

  const ProductAddEditScreen({super.key, this.productToEdit});

  @override
  State<ProductAddEditScreen> createState() => _ProductAddEditScreenState();
}

class _ProductAddEditScreenState extends State<ProductAddEditScreen> {
  final uploadService = UploadService();
  final shopController = Get.find<ShopController>();
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _itemNameController;
  late TextEditingController _descriptionController;
  late TextEditingController _brandController;
  late TextEditingController _recommendedForController;
  late TextEditingController _priceController;
  late TextEditingController _discountController;
  late TextEditingController _quantityController; // For Quantity

  File? _selectedImageFile;
  String? _existingImageUrl;

  bool _isLoading = false;
  final _imagePicker = ImagePicker();

  final List<String> _productCategories = [
    "FOOD",
    "VET_ITEMS",
    "ACCESSORIES",
    "IOT_DEVICES"
  ];
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _itemNameController =
        TextEditingController(text: widget.productToEdit?.itemName);
    _descriptionController =
        TextEditingController(text: widget.productToEdit?.description);
    _brandController = TextEditingController(text: widget.productToEdit?.brand);
    _selectedCategory = widget.productToEdit?.category;
    _recommendedForController =
        TextEditingController(text: widget.productToEdit?.recommendedFor);
    _priceController =
        TextEditingController(text: widget.productToEdit?.price?.toString());
    _discountController = TextEditingController(
        text: widget.productToEdit?.discount?.toString() ??
            '0'); // Default to 0 if null
    _quantityController = TextEditingController(
        text: widget.productToEdit?.quantity?.toString() ??
            '0'); // Default to 0 if null
    _existingImageUrl = widget.productToEdit?.photoUrl;
  }

  @override
  void dispose() {
    _itemNameController.dispose();
    _descriptionController.dispose();
    _brandController.dispose();
    _recommendedForController.dispose();
    _priceController.dispose();
    _discountController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile =
          await _imagePicker.pickImage(source: source, imageQuality: 80);
      if (pickedFile != null) {
        setState(() {
          _selectedImageFile = File(pickedFile.path);
          _existingImageUrl = null;
        });
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void _showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _saveProduct() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return; // If form is not valid, do nothing
    }
    if (_selectedCategory == null) {
      Get.snackbar('Validation Error', 'Please select a category.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    String? uploadedPhotoUrl = _existingImageUrl;

    if (_selectedImageFile != null) {
      try {
        // Ensure the path is not null before creating XFile
        uploadedPhotoUrl =
            await uploadService.uploadImage(XFile(_selectedImageFile!.path));
        print("Image uploaded: $uploadedPhotoUrl");
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        Get.snackbar('Upload Error', 'Failed to upload image: $e',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        return;
      }
    }

    if (uploadedPhotoUrl == null && widget.productToEdit == null) {
      setState(() {
        _isLoading = false;
      });
      Get.snackbar(
          'Validation Error', 'Please select an image for the new product.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }

    final int price = int.tryParse(_priceController.text) ?? 0;
    final int discount = int.tryParse(_discountController.text) ?? 0;
    final int discountedPrice = price - (price * discount ~/ 100);

    final productData = Product(
      id: widget.productToEdit?.id,
      itemName: _itemNameController.text,
      description: _descriptionController.text,
      brand: _brandController.text,
      category: _selectedCategory!,
      // Already checked for null
      recommendedFor: _recommendedForController.text,
      price: price,
      discount: discount,
      discountedPrice: discountedPrice,
      photoUrl: uploadedPhotoUrl,
      quantity: int.tryParse(_quantityController.text) ?? 0,
      reviewScore: widget.productToEdit?.reviewScore ?? 0.0,
      // Retain existing or default
      noOfReviews:
          widget.productToEdit?.noOfReviews ?? 0, // Retain existing or default
    );

    try {
      print("Saving product: ${productData.toJson()}");
      if (widget.productToEdit == null) {
        shopController
            .addNewProduct(productData); // Assuming addNewProduct is async
      } else {
        shopController
            .updateProduct(productData); // Assuming updateProduct is async
      }
      // Use Get.back(result: true) if the previous screen needs to know about success
      Get.back(canPop: true);
    } catch (e) {
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.productToEdit == null ? 'Add Product' : 'Edit Product'),
        // No actions here
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              GestureDetector(
                onTap: () => _showImageSourceActionSheet(context),
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: Center(
                    child: _selectedImageFile != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              _selectedImageFile!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          )
                        : _existingImageUrl != null &&
                                _existingImageUrl!.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  _existingImageUrl!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.broken_image,
                                          size: 50, color: Colors.grey),
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add_a_photo,
                                      size: 50, color: Colors.grey[700]),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Tap to select image',
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                ],
                              ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildTextFormField(
                controller: _itemNameController,
                labelText: 'Item Name',
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter item name'
                    : null,
              ),
              _buildTextFormField(
                controller: _descriptionController,
                labelText: 'Description',
                maxLines: 3,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter description'
                    : null,
              ),
              _buildTextFormField(
                controller: _brandController,
                labelText: 'Brand',
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter brand'
                    : null,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                  ),
                  value: _selectedCategory,
                  hint: const Text('Select Category'),
                  isExpanded: true,
                  items: _productCategories.map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCategory = newValue;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Please select a category' : null,
                ),
              ),
              _buildTextFormField(
                controller: _quantityController,
                labelText: 'Quantity in Stock',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter quantity';
                  }
                  final quantity = int.tryParse(value);
                  if (quantity == null) {
                    return 'Please enter a valid number';
                  }
                  if (quantity < 0) {
                    return 'Quantity cannot be negative';
                  }
                  return null;
                },
              ),
              _buildTextFormField(
                controller: _recommendedForController,
                labelText: 'Recommended For (e.g., Dogs, Cats)',
                // Making this optional for now, add validator if it's required
              ),
              _buildTextFormField(
                controller: _priceController,
                labelText: 'Price (Original)',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter price';
                  }
                  final price = int.tryParse(value);
                  if (price == null) {
                    return 'Please enter a valid number';
                  }
                  if (price < 0) {
                    return 'Price cannot be negative';
                  }
                  return null;
                },
              ),
              _buildTextFormField(
                controller: _discountController,
                labelText: 'Discount Percentage (0-100)',
                keyboardType: TextInputType.number,
                validator: (value) {
                  // Allow empty or 0 for no discount
                  if (value == null || value.isEmpty) {
                    // Default to 0 if empty, handled in _saveProduct
                    _discountController.text =
                        '0'; // auto-set to 0 if user leaves it blank
                    return null;
                  }
                  final discount = int.tryParse(value);
                  if (discount == null) {
                    return 'Please enter a valid number for discount';
                  }
                  if (discount < 0 || discount > 100) {
                    return 'Discount must be between 0 and 100';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor:
                        Theme.of(context).primaryColor, // Use theme color
                    foregroundColor: Colors.white, // Text color for button
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0))),
                onPressed: _isLoading ? null : _saveProduct,
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(widget.productToEdit == null
                        ? 'Add Product'
                        : 'Update Product'),
              ),
              const SizedBox(height: 20), // For bottom padding
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    bool isOptional =
        false, // Added to potentially skip validation if needed for some fields
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
          contentPadding: const EdgeInsets.symmetric(
              horizontal: 12, vertical: 15), // Adjusted padding
        ),
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: isOptional
            ? null
            : validator, // Apply validator only if not optional
      ),
    );
  }
}
