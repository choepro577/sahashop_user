import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:sahashop_user/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:sahashop_user/app_user/const/constant.dart';
import 'select_image_carousel_controller.dart';

class SelectCarouselImages extends StatelessWidget {
  SelectCarouselImagesController selectImageController =
      SelectCarouselImagesController();

  @override
  Widget build(BuildContext context) {
    selectImageController.init();
    return Container(
      child: Obx(() {
        var dataImages = selectImageController.dataImages.toList();

        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    addImage();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text("Thêm",
                        style: TextStyle(color: Colors.blueAccent)),
                  ),
                ),
              ],
            ),
            CarouselSlider(
              options:
                  CarouselOptions(height: 130.0, enableInfiniteScroll: false),
              items: dataImages.map((imageData) {
                return Builder(
                  builder: (BuildContext context) {
                    return buildItemImageData(imageData!);
                  },
                );
              }).toList(),
            ),
          ],
        );
      }),
    );
  }

  void addImage() {
    selectImageController.loadAssets();
  }

  Widget buildItemImageData(ImageData imageData) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
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
                                  : Image.file(
                                      imageData.file!,
                                      width: 300,
                                      height: 300,
                                    ),
                              SahaLoadingWidget(),
                            ],
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        )
                      : Image.file(
                          imageData.file!,
                          width: 300,
                          height: 300,
                        )),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: InkWell(
                onTap: () {
                  selectImageController.removeImage(
                     imageData
                  );
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
