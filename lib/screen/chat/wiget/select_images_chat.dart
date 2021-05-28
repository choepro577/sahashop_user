import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:sahashop_user/components/saha_user/loading/loading_widget.dart';
import 'package:sahashop_user/const/constant.dart';

import 'select_images_chat_controller.dart';

class SelectChatImages extends StatelessWidget {
  Function onUpload;
  Function doneUpload;

  SelectChatImageController selectImageController;
  SelectChatImages({this.onUpload, this.doneUpload}) {
    selectImageController = new SelectChatImageController(
        onUpload: onUpload, doneUpload: doneUpload);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      child: Obx(() {
        var dataImages = selectImageController.dataImages.toList();

        if (dataImages == null || dataImages.length == 0) return Container();

        return StaggeredGridView.countBuilder(
          crossAxisCount: 2,
          itemCount: dataImages.length,
          itemBuilder: (BuildContext context, int index) =>
              buildItemImageData(dataImages[index]),
          staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
          mainAxisSpacing: 0,
          crossAxisSpacing: 0,
        );
      }),
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
                          imageUrl: imageData.linkImage,
                          placeholder: (context, url) => Stack(
                            children: [
                              imageData.file == null
                                  ? Container()
                                  : AssetThumb(
                                      asset: imageData.file,
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
                          asset: imageData.file,
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
            imageData.uploading
                ? SahaLoadingWidget(
                    size: 50,
                  )
                : Container(),
            imageData.errorUpload ? Icon(Icons.error) : Container(),
          ],
        ),
      ),
    );
  }
}
