import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:sahashop_user/const/constant.dart';

class SelectProductImages extends StatelessWidget {
  SelectImageController selectImageController = new SelectImageController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      child: Obx(() {
        var deviceImages = selectImageController.deviceImages.toList();

        if (deviceImages == null || deviceImages.length == 0) return addImage();

        return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: deviceImages.length,
            itemBuilder: (context, index) {
              return buildItemAsset(deviceImages[index]);
            });
      }),
    );
  }
  Widget addImage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: InkWell(
        onTap: () {
          selectImageController.loadAssets();
        },
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              border: Border.all(color: SahaPrimaryColor,width: 3)
          ),
          child: Center(
            child: Icon(Icons.camera_alt_outlined),
          ),
        ),
      ),
    );
  }
  Widget buildItem() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        height: 100,
        width: 100,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: CachedNetworkImage(
                  height: 95,
                  width: 95,
                  fit: BoxFit.cover,
                  imageUrl:
                      "https://nld.mediacdn.vn/thumb_w/540/2020/5/29/doi-hoa-tim-8-15907313395592061395682.png",
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
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
            )
          ],
        ),
      ),
    );
  }



  Widget buildItemAsset(Asset asset) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        height: 100,
        width: 100,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Container(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: AssetThumb(
                    asset: asset,
                    width: 300,
                    height: 300,
                  )),
            ),
            Positioned(
              top: 0,
              right: 0,
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
            )
          ],
        ),
      ),
    );
  }
}

class SelectImageController extends GetxController {
  var deviceImages = <Asset>[].obs;

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: deviceImages,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    deviceImages(resultList);
  }
}
