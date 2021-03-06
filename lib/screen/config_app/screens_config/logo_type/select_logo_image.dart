import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:sahashop_user/components/saha_user/loading/loading_widget.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/const/constant.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart';

class SelectLogoImage extends StatelessWidget {
  SelectLogoImageController selectImageController =
      new SelectLogoImageController();
  final Function onChange;
  final String linkLogo;

  SelectLogoImage({Key key, this.onChange, this.linkLogo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      child: Obx(() {
        var deviceImage = selectImageController.pathImage;
        if (deviceImage.value == null || deviceImage.value == "")
          return addImage();
        return buildItemAsset(File(deviceImage.value));
      }),
    );
  }

  Widget addImage() {
    return selectImageController.isLoadingAdd.value
        ? SahaLoadingWidget()
        : Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: () {
                selectImageController.getImage(onOK: (link) {
                  onChange(link);
                });
              },
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    border: Border.all(color: SahaPrimaryColor)),
                child: linkLogo != null
                    ? CachedNetworkImage(
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                        imageUrl: linkLogo,
                        placeholder: (context, url) => new SahaLoadingWidget(
                          size: 30,
                        ),
                        errorWidget: (context, url, error) =>
                            new Icon(Icons.error),
                      )
                    : Center(
                        child: Icon(Icons.camera_alt_outlined),
                      ),
              ),
            ),
          );
  }

  Widget buildItemAsset(File asset) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            border: Border.all(color: SahaPrimaryColor)),
        child: SizedBox(
          height: 100,
          width: 100,
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Image.file(
                      asset,
                      fit: BoxFit.cover,
                      width: 300,
                      height: 300,
                    )),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: InkWell(
                  onTap: () {
                    selectImageController.removeImage();
                    onChange(null);
                  },
                  child: Container(
                    height: 17,
                    width: 17,
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                      border: Border.all(width: 1, color: Colors.white),
                    ),
                    child: Center(
                      child: Text(
                        "x",
                        style: TextStyle(
                          fontSize: 10,
                          height: 1,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
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

class SelectLogoImageController extends GetxController {
  var pathImage = "".obs;
  final picker = ImagePicker();
  var isLoadingAdd = false.obs;

  Future getImage({Function onOK, Function onError}) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      var file = File(pickedFile.path);

      final dir = await path_provider.getTemporaryDirectory();
      final targetPath = dir.absolute.path + basename(pickedFile.path);

      var result = await FlutterImageCompress.compressAndGetFile(
          file.absolute.path, targetPath,
          quality: 60, minHeight: 512, minWidth: 512);

      var link = await upLogo(result);
      onOK(link);
      pathImage.value = pickedFile.path;
    } else {
      SahaAlert.showError(message: "C?? l???i khi up logo");
      print('No image selected.');
    }
  }

  void removeImage() {
    pathImage.value = null;
  }

  Future<String> upLogo(File file) async {
    isLoadingAdd.value = true;
    try {
      var link = await RepositoryManager.imageRepository.uploadImage(file);
      isLoadingAdd.value = false;
      return link;
    } catch (err) {
      isLoadingAdd.value = false;
      SahaAlert.showError(message: err.toString());
    }
  }
}
