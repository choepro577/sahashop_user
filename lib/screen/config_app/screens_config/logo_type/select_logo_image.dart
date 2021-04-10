import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:sahashop_user/const/constant.dart';

class SelectLogoImage extends StatelessWidget {
  SelectLogoImageController selectImageController =
      new SelectLogoImageController();
  final Function onChange;

  SelectLogoImage({Key key, this.onChange}) : super(key: key);

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
    return Align(
      alignment: Alignment.centerLeft,
      child: InkWell(
        onTap: () {
          selectImageController.getImage((file) {
            onChange(file);
          });
        },
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              border: Border.all(color: SahaPrimaryColor)),
          child: Center(
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
  Future getImage(Function onPick) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      onPick(File(pickedFile.path));
      pathImage.value = pickedFile.path;
    } else {
      print('No image selected.');
    }
  }

  void removeImage() {
    pathImage.value = null;
  }
}
