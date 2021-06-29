import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sahashop_user/components/app_customer/repository/repository_customer.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/const/constant.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/model/info_customer.dart';
import 'package:sahashop_user/screen/config_app/screens_config/header_config/image_carousel/select_image_carousel_controller.dart';
import 'package:sahashop_user/utils/image_utils.dart';

import 'package:image_cropper/image_cropper.dart';

class ConfigProfileController extends GetxController {
  InfoCustomer? infoCustomer;
  var sex = "".obs;
  var sexIndex = 0;
  var linkAvatar = "".obs;
  var isUpdatingImage = false.obs;
  Rx<ImageData?> dataImages = ImageData().obs;
  var birthDate = DateTime.now().obs;

  var nameEditingController = new TextEditingController().obs;
  var phoneEditingController = new TextEditingController().obs;
  var emailEditingController = new TextEditingController().obs;
  var passwordEditingController = new TextEditingController().obs;

  SelectCarouselImagesController selectImageController =
      SelectCarouselImagesController();

  ConfigProfileController({this.infoCustomer}) {
    nameEditingController.value.text = infoCustomer!.name ?? "";
    phoneEditingController.value.text = infoCustomer!.phoneNumber ?? "";
    emailEditingController.value.text =
        infoCustomer!.email ?? "contactsahatech@gmail.com";
    passwordEditingController.value.text = infoCustomer!.email ?? "";
    linkAvatar.value = infoCustomer!.avatarImage ?? "";
    print(linkAvatar.value);
    onChangeSexPicker(infoCustomer!.sex ?? 0);
    birthDate.value =
        DateTime.parse(infoCustomer!.dateOfBirth ?? "1972-05-14T16:00:00.000");
    dataImages.value = ImageData(
        linkImage: infoCustomer!.avatarImage,
        uploading: false,
        errorUpload: false);
  }

  void onChangeSexPicker(int value) {
    if (value == 0) {
      sex.value = "Khác";
      sexIndex = 0;
    } else {
      if (value == 1) {
        sex.value = "Nam";
        sexIndex = 1;
      } else {
        sex.value = "Nữ";
        sexIndex = 2;
      }
    }
  }

  Future<void> updateProfileCustomer() async {
    try {
      var res = await CustomerRepositoryManager.infoCustomerRepository
          .updateAccountCustomer(InfoCustomer(
        name: nameEditingController.value.text,
        sex: sexIndex,
        avatarImage: linkAvatar.value,
        dateOfBirth: birthDate.value,
      ));
      Get.back();
      SahaAlert.showError(message: "Sửa thành công");
    } catch (err) {
      SahaAlert.showError(message: "Có lỗi xin thử lại");
    }
  }

  void updateImage({ImageData? imageData}) {
    dataImages.value = imageData;
  }

  Future<String?> uploadImage(File file) async {
    isUpdatingImage.value = true;
    try {
      var fileUpImageCompress =
          await ImageUtils.getImageCompress(file, quality: 80);

      var link = (await RepositoryManager.imageRepository
          .uploadImage(fileUpImageCompress))!;

      //OK up load
      updateImage(
          imageData:
              ImageData(linkImage: link, uploading: false, errorUpload: false));
      linkAvatar.value = link;
    } catch (err) {
      updateImage(
          imageData:
              ImageData(file: file, uploading: false, errorUpload: true));

      SahaAlert.showError(message: "Có lỗi khi up ảnh xin thử lại");
    }
    isUpdatingImage.value = false;
  }

  Future<String?> loadAssets() async {
    try {
      final picker = ImagePicker();
      final pickedFile = (await picker.getImage(source: ImageSource.gallery))!;
      File? croppedFile = await ImageCropper.cropImage(
          compressQuality: 10,
          sourcePath: pickedFile.path,
          aspectRatioPresets: [CropAspectRatioPreset.ratio16x9],
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Cắt ảnh',
              toolbarColor: SahaPrimaryColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: true),
          iosUiSettings: IOSUiSettings(
            minimumAspectRatio: 9 / 16,
            aspectRatioLockEnabled: false,
            aspectRatioLockDimensionSwapEnabled: false,
            rotateButtonsHidden: false,
            title: 'Cắt ảnh',
          ));

      if (croppedFile == null) return "";

      dataImages.value =
          ImageData(file: croppedFile, uploading: true, errorUpload: false);

      return await uploadImage(croppedFile);
    } on Exception catch (e) {
      return null;
    }
  }
}
