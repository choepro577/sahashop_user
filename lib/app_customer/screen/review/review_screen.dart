import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../screen/review/review_controller.dart';
import '../../screen/review/widget/select_image_review.dart';
import '../../screen/review/widget/star.dart';
import '../../screen/review/widget/text_field_choose.dart';
import 'package:sahashop_user/app_user/const/const_image_logo.dart';
import 'package:sahashop_user/app_user/model/order.dart';
import 'package:sahashop_user/app_user/screen/inventory/products/add_product/widget/select_images_controller.dart';

// ignore: must_be_immutable
class ReviewScreen extends StatelessWidget {
  final List<LineItemsAtTime>? lineItemsAtTime;
  final String? orderCode;
  ReviewScreen({this.lineItemsAtTime, this.orderCode}) {
    reviewController = ReviewController(
        lineItemsAtTimeInput: lineItemsAtTime, orderCodeInput: orderCode);
  }
  ReviewController? reviewController;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text("Đánh giá sản phẩm"),
              Spacer(),
              TextButton(
                  onPressed: () {
                    reviewController!.reviewAllOrder();
                  },
                  child: Text(
                    "Gửi",
                    style: TextStyle(
                        color:
                            Theme.of(context).primaryTextTheme.headline6!.color,
                        fontSize: 15),
                  ))
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ...List.generate(reviewController!.lineItemsAtTimeInput!.length,
                  (index) => itemReview(index)),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemReview(int index) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: CachedNetworkImage(
                    width: 30,
                    height: 30,
                    fit: BoxFit.cover,
                    imageUrl:
                        "${reviewController!.lineItemsAtTimeInput![index].imageUrl}",
                    errorWidget: (context, url, error) => ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      child: CachedNetworkImage(
                          fit: BoxFit.cover, imageUrl: logoSahaImage),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                    "${reviewController!.lineItemsAtTimeInput![index].name ?? "Loading..."}")
              ],
            ),
          ),
          Divider(
            height: 1,
          ),
          Obx(
            () => Star(
              starInput: reviewController!.listStar[index],
              onTap: (int star) {
                reviewController!.listStar[index] = star;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SelectImagesReview(
              onUpload: () {
                reviewController!.setUploadingImages(true);
              },
              images: reviewController!.listImages![index].isEmpty
                  ? null
                  : reviewController!.listImages![index],
              doneUpload: (List<ImageData> listImages) {
                print(
                    "done upload image ${listImages.length} images => ${listImages.toList().map((e) => e.linkImage).toList()}");
                reviewController!.setUploadingImages(true);
                reviewController!.listImages![index] = listImages;
                listImages.forEach((image) {
                  reviewController!.listImageRequest![index]
                      .add(image.linkImage!);
                });
                print(reviewController!.listImageRequest!);
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFieldChoose(
            listChooseText: reviewController!.listChooseText,
            textInput: reviewController!.listContent[index],
            onChange: (v) {
              reviewController!.listContent[index] = v;
              print(reviewController!.listContent);
            },
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 8,
            color: Colors.grey[200],
          )
        ],
      ),
    );
  }
}
