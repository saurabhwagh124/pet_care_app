import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_care_app/model/notification_dto_model.dart';
import 'package:pet_care_app/service/notification_service.dart';
import 'package:pet_care_app/service/upload_service.dart';
import 'package:pet_care_app/utils/add_pet_vaildator.dart';
import 'package:pet_care_app/utils/app_colors.dart';

class AddNotificationsScreen extends StatefulWidget {
  const AddNotificationsScreen({super.key});

  @override
  State<AddNotificationsScreen> createState() => _AddNotificationsScreenState();
}

class _AddNotificationsScreenState extends State<AddNotificationsScreen> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  final notifiService = NotificationService();
  final uploadService = UploadService();
  String? photoUrl;
  XFile? image;
  final _picker = ImagePicker();

  Future<void> _pickImages() async {
    final XFile? pickedFiles =
        await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = pickedFiles;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Add Notifications"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 25.sp),
          onPressed: () => Get.back(),
        ),
        backgroundColor: AppColors.yellowCircle,
      ),
      body: Padding(
        padding: EdgeInsets.all(10.sp),
        child: Center(
          child: Column(
            spacing: 10.h,
            children: [
              (image == null)
                  ? SizedBox(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: _pickImages,
                              icon: Icon(
                                Icons.add_photo_alternate,
                                color: Colors.blue,
                                size: 40.sp,
                              )),
                          Text(
                            "Add an image",
                            style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          )
                        ],
                      ),
                    )
                  : SizedBox(width: 50.w, child: Image.file(File(image!.path))),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200], // Light grey background
                  borderRadius: BorderRadius.circular(8), // Rounded corners
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12, // Light shadow
                      blurRadius: 4, // Slight blur
                      offset: Offset(2, 2), // Shadow position
                    ),
                  ],
                ),
                padding: EdgeInsets.all(10.sp),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) =>
                      Validation.validateNotNull(value, "Add Title"),
                  decoration: const InputDecoration(
                      border: InputBorder.none, labelText: "Add Title"),
                  controller: titleController,
                  maxLines: 1,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200], // Light grey background
                  borderRadius: BorderRadius.circular(8), // Rounded corners
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12, // Light shadow
                      blurRadius: 4, // Slight blur
                      offset: Offset(2, 2), // Shadow position
                    ),
                  ],
                ),
                padding: EdgeInsets.all(10.sp),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) =>
                      Validation.validateNotNull(value, "Add Body"),
                  decoration: const InputDecoration(
                      border: InputBorder.none, labelText: "Add Body"),
                  controller: bodyController,
                  maxLines: 4,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if (image != null) {
                    photoUrl = await uploadService.uploadImage(image!);
                  }
                  await notifiService.addNotificationToAll(NotificationDtoModel(
                      title: titleController.text,
                      body: bodyController.text,
                      image: photoUrl));
                  image = null;
                  titleController.clear();
                  bodyController.clear();
                  Get.back();
                },
                child: Container(
                  margin: EdgeInsets.all(20.sp),
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 187, 98),
                      borderRadius: BorderRadius.circular(30.r)),
                  child: Text(
                    "Send Notification",
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(255, 230, 89, 46)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
