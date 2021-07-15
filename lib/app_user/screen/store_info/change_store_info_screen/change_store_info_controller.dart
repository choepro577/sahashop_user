import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/store/all_store_response.dart';
import 'package:sahashop_user/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/app_user/const/constant.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/store/type_store_respones.dart';
import 'package:sahashop_user/app_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/app_user/screen/config_app/screens_config/main_component_config/image_carousel/select_image_carousel_controller.dart';
import 'package:sahashop_user/app_user/screen/home/home_controller.dart';
import 'package:sahashop_user/app_user/utils/image_utils.dart';

import 'package:image_cropper/image_cropper.dart';

class ChangeStoreInfoController extends GetxController {
  var store = Store().obs;
  var sex = "".obs;
  var logoUrl = "".obs;
  var idTypeShop = 0.obs;
  var isUpdatingImage = false.obs;
  Rx<ImageData?> dataImages = ImageData().obs;
  RxList<DataTypeShop>?  listDataType = RxList<DataTypeShop>();


  var nameEditingController = new TextEditingController().obs;
  var addressEditingController = new TextEditingController().obs;

  SelectCarouselImagesController selectImageController =
      SelectCarouselImagesController();

  ChangeStoreInfoController() {
    HomeController homeController = Get.find();
    store(homeController.storeCurrent! .value);
    nameEditingController.value.text = store.value.name ?? "";
    addressEditingController.value.text = store.value.address ?? "";


    idTypeShop.value = store.value.idTypeOfStore ?? -1;
    logoUrl.value = store.value.logoUrl ?? "";
    
    dataImages.value = ImageData(
        linkImage: store.value.logoUrl,
        uploading: false,
        errorUpload: false);

    getAllShopType();

  }

  Future<List<DataTypeShop>?> getAllShopType() async {
    try {
      var listDataTypeShop =
      (await RepositoryManager.typeOfShopRepository.getAll())!;

      listDataType!(listDataTypeShop);


      store.refresh();

    } catch (err) {}
  }
  
 
  void changeType(int typeI) {
    String nameType ="";
    for(var type in  listDataType!) {
      if(type.id == typeI) {
        nameType = type.name!;
      }
    }
    idTypeShop.value = typeI;
    
    store.value.nameType = nameType;
    store.refresh();
  }
  

  Future<void> updateInfoStore() async {
    try {
      var res = await RepositoryManager.storeRepository
          .update(
        store.value.storeCode,
        nameShop: nameEditingController.value.text,
        address: addressEditingController.value.text,
        logoUrl: logoUrl.value,
          idTypeShop:idTypeShop.value
      );
      HomeController homeController = Get.find();
      homeController.storeCurrent!(res);

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
          await ImageUtils.getImageCompress(file, quality: 20);

      var link = (await RepositoryManager.imageRepository
          .uploadImage(fileUpImageCompress))!;

      //OK up load
      updateImage(
          imageData:
              ImageData(linkImage: link, uploading: false, errorUpload: false));
      logoUrl.value = link;
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
