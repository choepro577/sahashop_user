import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sahashop_user/controller/config_controller.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/model/banner.dart';
import 'package:sahashop_user/utils/image_utils.dart';

import 'package:image_cropper/image_cropper.dart';

import '../../../../../components/saha_user/toast/saha_alert.dart';
import '../../../../../const/constant.dart';

class SelectCarouselImagesController extends GetxController {
  Function onUpload;
  Function doneUpload;

  var dataImages = <ImageData>[].obs;

  void init() {
    dataImages([]);
    ConfigController configController = Get.find();

    if (configController.configApp?.carouselAppImages != null) {
      final listCarousel = configController.configApp?.carouselAppImages;

      dataImages(listCarousel
          .map((e) => ImageData(
              linkImage: e.imageUrl, uploading: false, errorUpload: false))
          .toList());
    }
  }

  void removeImage(ImageData imageData) {
    dataImages.remove(imageData);
    updateBannerToConfig();
  }

  void updateBannerToConfig() {
    ConfigController configController = Get.find();

    var banners = <BannerItem>[];

    dataImages.forEach((imageData) {
      if (imageData.linkImage != null) {
        banners.add(BannerItem(
          imageUrl: imageData.linkImage,
          title: ""
        ));
      }
    });

    configController.configApp.carouselAppImages = banners;
    configController.createAppTheme();
  }

  void updateImage({int index, ImageData imageData}) {
    var  indexWithLength = index-1;
    var newList = dataImages.toList();

      newList[indexWithLength] = imageData;

    dataImages(newList);
  }

  Future<String> uploadImage(File file) async {
    try {
      var fileUpImageCompress = await ImageUtils.getImageCompress(file,

      quality: 90);

      var link = await RepositoryManager.imageRepository
          .uploadImage(fileUpImageCompress);

      //OK up load
      updateImage(
          index: dataImages.length,
          imageData:
              ImageData(linkImage: link, uploading: false, errorUpload: false));

      updateBannerToConfig();

      return link;
    } catch (err) {
      updateImage(
          index: dataImages.length,
          imageData:
              ImageData(file: file, uploading: false, errorUpload: true));

      updateBannerToConfig();
      SahaAlert.showError(message: "Có lỗi khi up ảnh xin thử lại");
    }
  }

  Future<String> loadAssets() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      File croppedFile = await ImageCropper.cropImage(
        compressQuality: 100,
          sourcePath: pickedFile.path,
          aspectRatioPresets: [CropAspectRatioPreset.ratio16x9],
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Cắt ảnh',
              toolbarColor: SahaPrimaryColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: true),
          iosUiSettings: IOSUiSettings(
            minimumAspectRatio: 1.0,
          ));

      if(croppedFile == null) return "";

      dataImages.add(
          ImageData(file: croppedFile, uploading: true, errorUpload: false));

      return await uploadImage(croppedFile);
    } on Exception catch (e) {
      return null;
    }
  }
}

class ImageData {
  File file;
  String linkImage;
  bool errorUpload;
  bool uploading;

  ImageData({this.file, this.linkImage, this.errorUpload, this.uploading});
}
