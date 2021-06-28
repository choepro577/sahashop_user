import 'dart:io';

import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/screen/inventory/products/add_product/widget/select_images_controller.dart';
import 'package:sahashop_user/utils/image_utils.dart';

class SelectImageReviewController extends GetxController {
  Function? onUpload;
  Function? doneUpload;
  SelectImageReviewController({this.onUpload, this.doneUpload});

  var dataImages = <ImageData>[].obs;

  void deleteImage(Asset? asset) {
    var indexRm =
        dataImages.toList().map((e) => e.file).toList().indexOf(asset);

    dataImages.removeAt(indexRm);

    updateListImage(dataImages.map((element) => element.file).toList());
    doneUpload!(dataImages.toList());
  }

  void updateListImage(List<Asset?> listAsset) {
    print(listAsset);
    onUpload!();

    var listPre = dataImages.toList();
    var newList = <ImageData>[];

    for (var asset in listAsset) {
      var dataPre =
          listPre.firstWhereOrNull((itemPre) => itemPre.file == asset);

      if (dataPre != null) {
        newList.add(dataPre);
      } else {
        newList.add(ImageData(
            file: asset,
            linkImage: null,
            errorUpload: false,
            uploading: false));
      }
    }
    dataImages(newList);
    uploadListImage();
  }

  void uploadListImage() async {
    int stackComplete = 0;

    var responses = await Future.wait(dataImages.map((imageData) {
      if (imageData.linkImage == null) {
        return uploadImageData(
            indexImage: dataImages.indexOf(imageData),
            onOK: () {
              stackComplete++;
            });
      } else
        return Future.value(null);
    }));

    doneUpload!(dataImages.toList());
  }

  Future<void> uploadImageData(
      {required int indexImage, required Function onOK}) async {
    try {
      dataImages[indexImage].uploading = true;
      dataImages.refresh();

      var fileUp =
          await ImageUtils.getImageFileFromAsset(dataImages[indexImage].file);
      var fileUpImageCompress = await ImageUtils.getImageCompress(fileUp!);

      var link = await RepositoryManager.imageRepository
          .uploadImage(fileUpImageCompress);

      dataImages[indexImage].linkImage = link;
      dataImages[indexImage].errorUpload = false;
      dataImages[indexImage].uploading = false;
      dataImages.refresh();
    } catch (err) {
      print(err);
      dataImages[indexImage].linkImage = null;
      dataImages[indexImage].errorUpload = true;
      dataImages[indexImage].uploading = false;
      dataImages.refresh();
    }
    onOK();
  }

  Future<File> getImageFileFromAssetsAndroid(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  Future<void> loadAssets() async {
    List<Asset?> resultList = <Asset?>[];
    String error = 'No Error Detected';
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: MAX_SELECT - resultList.length,
        enableCamera: true,
        selectedAssets: dataImages.toList().map((e) => e.file!).toList(),
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "SahaShop",
          allViewTitle: "Mời chọn ảnh",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }
    updateListImage(resultList);
  }
}
