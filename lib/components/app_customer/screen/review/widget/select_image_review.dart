import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:sahashop_user/components/app_customer/screen/review/widget/selecte_image_review_controller.dart';
import 'package:sahashop_user/components/saha_user/loading/loading_widget.dart';
import 'package:sahashop_user/screen/inventory/products/add_product/widget/select_images_controller.dart';

// ignore: must_be_immutable
class SelectImagesReview extends StatelessWidget {
  Function? onUpload;
  Function? doneUpload;
  final List<ImageData>? images;

  late SelectImageReviewController selectImageController;
  SelectImagesReview({this.onUpload, this.doneUpload, this.images}) {
    selectImageController = new SelectImageReviewController(
        onUpload: onUpload, doneUpload: doneUpload);

    if (images != null) {
      selectImageController.dataImages.value = images!;
    }
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
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Tối đa 5 hình, có thể thêm sau",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
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
                  SizedBox(
                    width: 5,
                  ),
                  index == dataImages.length - 1 && dataImages.length < 5
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
          height: 80,
          width: 80,
          decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.all(Radius.circular(2)),
              border: Border.all(color: Theme.of(Get.context!).primaryColor)),
          child: Center(
            child: Icon(
              Icons.camera_alt_outlined,
              color: Theme.of(Get.context!).primaryColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildItemImageData(ImageData imageData) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        height: 80,
        width: 80,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Container(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(2.0),
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
            imageData.errorUpload!
                ? Icon(
                    Icons.error,
                    color: Colors.redAccent,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
