import 'dart:io';

import 'package:get/get.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';

final MAX_SELECT = 10;

class SelectImageController extends GetxController {
  Function onUpload;
  Function doneUpload;
  SelectImageController({this.onUpload, this.doneUpload});

  var dataImages = <ImageData>[].obs;

  void deleteImage(Asset asset) {
    var indexRm =
        dataImages.toList().map((e) => e.file).toList().indexOf(asset);
    dataImages.removeAt(indexRm);
    updateListImage(dataImages.map((element) => element.file).toList());
  }

  void updateListImage(List<Asset> listAsset) {
    onUpload();

    var listPre = dataImages.toList();
    var newList = <ImageData>[];

    for (var file in listAsset) {
      var dataPre = listPre.firstWhere((itemPre) => itemPre.file == file,
          orElse: () => null);

      if (dataPre != null) {
        newList.add(dataPre);
      }
      newList.add(ImageData(
          file: file, linkImage: null, errorUpload: false, uploading: false));
    }
    dataImages(newList);
    uploadListImage();
  }

  void uploadListImage() {
    int stackComplete = 0;

    int indexImageData = 0;
    for (var imageData in dataImages) {
      if (imageData.linkImage == null) {
        uploadImageData(indexImageData, () {
          stackComplete++;
          if (stackComplete == dataImages.length) {
            doneUpload(dataImages.toList());
          }
        });
      }
      indexImageData++;
    }
  }

  void uploadImageData(int indexImage, Function onOK) async {
    try {
      dataImages[indexImage].uploading = true;
      dataImages.refresh();
      var link = await RepositoryManager.imageRepository.uploadImage(
          await getImageFileFromAssets(dataImages[indexImage].file));

      dataImages[indexImage].linkImage = link;

      print( dataImages[indexImage].linkImage);
      dataImages[indexImage].errorUpload = false;
      dataImages[indexImage].uploading = false;
      dataImages.refresh();
    } catch (err) {
      dataImages[indexImage].linkImage = null;
      dataImages[indexImage].errorUpload = true;
      dataImages[indexImage].uploading = false;
      dataImages.refresh();
    }
    onOK();
  }

  Future<File> getImageFileFromAssets(Asset asset) async {
    final byteData = await asset.getByteData();

    final tempFile =
        File("${(await getTemporaryDirectory()).path}/${asset.name}");
    final file = await tempFile.writeAsBytes(
      byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
    );

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
