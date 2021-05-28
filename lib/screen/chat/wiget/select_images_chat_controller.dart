import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path_provider/path_provider.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:path/path.dart';
import 'package:sahashop_user/utils/image_utils.dart';

final MAX_SELECT = 10;

class SelectChatImageController extends GetxController {
  Function onUpload;
  Function doneUpload;
  SelectChatImageController({this.onUpload, this.doneUpload});

  var dataImages = <ImageData>[].obs;

  void deleteImage(Asset asset) {
    var indexRm =
        dataImages.toList().map((e) => e.file).toList().indexOf(asset);

    dataImages.removeAt(indexRm);

    updateListImage(dataImages.map((element) => element.file).toList());
    doneUpload(dataImages.toList());
  }

  void updateListImage(List<Asset> listAsset) {
    print(listAsset);
    onUpload();

    var listPre = dataImages.toList();
    var newList = <ImageData>[];

    for (var asset in listAsset) {
      var dataPre = listPre.firstWhere((itemPre) => itemPre.file == asset,
          orElse: () => null);

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

    doneUpload(dataImages.toList());
  }

  Future<void> uploadImageData({int indexImage, Function onOK}) async {
    try {
      dataImages[indexImage].uploading = true;
      dataImages.refresh();

      var fileUp =
          await ImageUtils.getImageFileFromAsset(dataImages[indexImage].file);
      var fileUpImageCompress = await ImageUtils.getImageCompress(fileUp);

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

  Future<File> getImageFileFromAssetsIos(Asset asset) async {
    var path = await FlutterAbsolutePath.getAbsolutePath(asset.identifier);
    final dir = await path_provider.getTemporaryDirectory();
    final targetPath = dir.absolute.path + basename(path);

    var file = await FlutterImageCompress.compressAndGetFile(path, targetPath,
        quality: 20, minHeight: 1024, minWidth: 1024);

    return file;
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: MAX_SELECT - resultList.length,
        enableCamera: true,
        selectedAssets: dataImages.toList().map((e) => e.file).toList(),
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

class ImageData {
  Asset file;
  String linkImage;
  bool errorUpload;
  bool uploading;

  ImageData({this.file, this.linkImage, this.errorUpload, this.uploading});
}
