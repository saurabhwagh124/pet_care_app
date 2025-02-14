import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:pet_care_app/network/api_endpoints.dart';

class UploadService extends GetxService {
  Future<String?> uploadImage(XFile file) async {
    var request = http.MultipartRequest('POST', Uri.parse(ApiEndpoints.postUploadFileUrl));

    request.files.add(await http.MultipartFile.fromPath(
      'file',
      file.path,
    ));

    try {
      final response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        return responseBody;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<String>> uploadMultipleFiles(List<XFile> files) async {
    var request = http.MultipartRequest('POST', Uri.parse(ApiEndpoints.postUploadMultipleFilesUrl));

    for (XFile file in files) {
      request.files.add(
        await http.MultipartFile.fromPath('files', file.path),
      );
    }

    var response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      List<String> fileUrls = List<String>.from(jsonDecode(responseBody));
      log('Upload successful: $fileUrls');
      return fileUrls;
    } else {
      log('Upload failed: ${response.reasonPhrase}');
      throw Exception("Upload failed: ${response.statusCode}");
    }
  }
}
