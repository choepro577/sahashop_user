import 'dart:io';
import 'package:dio/dio.dart';
import 'package:sahashop_user/data/remote/saha_service_manager.dart';
import '../handle_error.dart';

class ImageRepository {
  Future<String?> uploadImage(File? image) async {
    try {
      var res = await SahaServiceManager().service!.uploadImage(
        {
          "image": image == null
              ? null
              : await MultipartFile.fromFile(image.path),
        },
      );
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }
}
