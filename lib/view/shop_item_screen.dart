import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/controller/shop_controller.dart';
import 'package:pet_care_app/model/product.dart';
import 'package:pet_care_app/utils/app_colors.dart';
import 'package:pet_care_app/widgets/admin/add_edit_shopitem.dart';
import 'package:pet_care_app/widgets/product_card.dart';

class ShopItemScreen extends StatefulWidget {
  const ShopItemScreen({super.key});

  @override
  State<ShopItemScreen> createState() => _ShopItemScreenState();
}

class _ShopItemScreenState extends State<ShopItemScreen> {
  final shopController = ShopController();
  RxString category = RxString("All");
  RxList<Product> mainList = <Product>[].obs;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    shopController.fetchAllProducts();
    });
  }

  @override
  void dispose() {
    shopController.dispose();
    super.dispose();
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
        title: const Text('Shop Items'),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 10.h, left: 40.w, right: 40.w),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 100.w,
                ),
                Text(
                  "Filter: ",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Expanded(
                  child: DropdownButtonFormField(
                    alignment: Alignment.center,
                    dropdownColor: Colors.orange[100],
                    // icon: const Icon(Icons.filter_alt),
                    decoration: const InputDecoration(
                        focusColor: Colors.orangeAccent,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange))),
                    value: "All",
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    menuMaxHeight: 200.h,
                    itemHeight: 50.h,
                    items: [
                      dropDownItems("All"),
                      dropDownItems("Food Items"),
                      dropDownItems("Vet Items"),
                      dropDownItems("Iot Items"),
                      dropDownItems("Accessories")
                    ],
                    onChanged: (value) {
                      category.value = value.toString();
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              child: Obx(() {
                final value = category.value;
                switch (value) {
                  case "All":
                    mainList.value = [
                      ...shopController.vetItemsList,
                      ...shopController.iotList,
                      ...shopController.foodList,
                      ...shopController.accList,
                    ];
                    break;
                  case "Food Items":
                    mainList.value = shopController.foodList;
                    break;
                  case "Vet Items":
                    mainList.value = shopController.vetItemsList;
                    break;
                  case "Iot Items":
                    mainList.value = shopController.iotList;
                    break;
                  case "Accessories":
                    mainList.value = shopController.accList;
                    break;
                }
                if (shopController.isLoading.value) {
                  return const Center(
                      child: CircularProgressIndicator(color: Colors.green));
                }
                return ListView.builder(
                  itemCount: mainList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ProductCard(
                        addToCart: false,
                        product: mainList[index],
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Get.to(() => AddUpdateItemView());
        },
      ),
    );
  }

  DropdownMenuItem<String> dropDownItems(String text) {
    return DropdownMenuItem(
        value: text,
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium,
        ));
  }
}
