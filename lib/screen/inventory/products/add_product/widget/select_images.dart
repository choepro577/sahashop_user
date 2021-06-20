import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:sahashop_user/components/saha_user/loading/loading_widget.dart';
import 'package:sahashop_user/const/constant.dart';

import 'select_images_controller.dart';

class SelectProductImages extends StatelessWidget {
  Function? onUpload;
  Function? doneUpload;

  late SelectImageController selectImageController;
  SelectProductImages({this.onUpload, this.doneUpload}) {
    selectImageController =
        new SelectImageController(onUpload: onUpload, doneUpload: doneUpload);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      child: Obx(() {
        var dataImages = selectImageController.dataImages.toList();

        if (dataImages == null || dataImages.length == 0)
          return Row(
            children: [
              addImage(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Ảnh sản phẩm"),
                        Text(
                          "Tối đa 10 hình, có thể thêm sau",
                          style: TextStyle(
                              color: Colors.grey, fontStyle: FontStyle.italic),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          );

        return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: dataImages.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  buildItemImageData(dataImages[index]),
                  index == dataImages.length - 1 &&
                          dataImages.length < MAX_SELECT
                      ? addImage()
                      : Container()
                ],
              );
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
              border: Border.all(color: SahaPrimaryColor)),
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
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            border: Border.all(color: SahaPrimaryColor)),
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

  Widget buildItemImageData(ImageData imageData) {
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
                  child: imageData.linkImage != null
                      ? CachedNetworkImage(
                          height: 300,
                          width: 300,
                          fit: BoxFit.cover,
                          imageUrl: imageData.linkImage!,
                          placeholder: (context, url) => Stack(
                            children: [
                              imageData.file == null
                                  ? Container()
                                  : AssetThumb(
                                      asset: imageData.file!,
                                      width: 300,
                                      height: 300,
                                      spinner: SahaLoadingWidget(
                                        size: 50,
                                      ),
                                    ),
                              SahaLoadingWidget(),
                            ],
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        )
                      : AssetThumb(
                          asset: imageData.file!,
                          width: 300,
                          height: 300,
                          spinner: SahaLoadingWidget(
                            size: 50,
                          ),
                        )),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: InkWell(
                onTap: () {
                  selectImageController.deleteImage(imageData.file);
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
            ),
            imageData.uploading!
                ? SahaLoadingWidget(
                    size: 50,
                  )
                : Container(),
            imageData.errorUpload! ? Icon(Icons.error) : Container(),
          ],
        ),
      ),
    );
  }
}
