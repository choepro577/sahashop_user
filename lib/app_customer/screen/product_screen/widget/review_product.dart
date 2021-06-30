import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:readmore/readmore.dart';
import 'package:sahashop_user/app_customer/screen/review/see_review/see_review_screen.dart';
import 'package:sahashop_user/app_user/const/const_image_logo.dart';
import 'package:sahashop_user/app_user/model/review.dart';
import 'package:sahashop_user/app_user/utils/date_utils.dart';

class ReviewProduct extends StatelessWidget {
  final int? idProduct;
  final double? averagedStars;
  final int? totalReview;
  final List<String>? listAllImage;
  final List<Review>? listReview;
  final List<List<dynamic>>? listImageReviewOfCustomer;

  ReviewProduct({
    this.idProduct,
    this.averagedStars,
    this.totalReview,
    this.listAllImage,
    this.listReview,
    this.listImageReviewOfCustomer,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            Get.to(() => SeeReviewScreen(
                  idProduct: idProduct,
                ));
          },
          child: Container(
            padding: EdgeInsets.only(top: 15, bottom: 10, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ĐÁNH GIÁ SẢN PHẨM",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 9,
                    ),
                    Row(
                      children: [
                        RatingBarIndicator(
                          rating: averagedStars!,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 15.0,
                          direction: Axis.horizontal,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${averagedStars ?? 5}/5",
                          style: TextStyle(color: Colors.red),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "(${totalReview ?? 0} Đánh giá)",
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey[200]),
                  child: Row(
                    children: [
                      Text(
                        "Xem tất cả",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SvgPicture.asset("assets/icons/right_arrow.svg",
                          height: 10,
                          width: 10,
                          color: Theme.of(context).primaryColor)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Divider(
          height: 1,
        ),
        SizedBox(
          height: 5,
        ),
        listAllImage!.isEmpty
            ? Container()
            : Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("Hình ảnh Người Mua"),
              ),
        listAllImage!.isEmpty
            ? Container()
            : Container(
                height: (Get.width / 4 - 10) + 20,
                width: Get.width,
                padding: const EdgeInsets.all(5.0),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        listAllImage!.length <= 4 ? listAllImage!.length : 4,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                seeImage(
                                  listImageUrl: listAllImage!,
                                  index: index,
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(2),
                                child: CachedNetworkImage(
                                  width: Get.width / 4 - 12,
                                  height: Get.width / 4 - 12,
                                  fit: BoxFit.cover,
                                  imageUrl: "${listAllImage![index]}",
                                  errorWidget: (context, url, error) =>
                                      ClipRRect(
                                    borderRadius: BorderRadius.circular(2),
                                    child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: logoSahaImage),
                                  ),
                                ),
                              ),
                            ),
                            listAllImage!.length > 4 && index == 3
                                ? InkWell(
                                    onTap: () {
                                      seeImage(
                                        listImageUrl: listAllImage!,
                                        index: index,
                                      );
                                    },
                                    child: Container(
                                      width: Get.width / 4 - 12,
                                      height: Get.width / 4 - 12,
                                      color: Colors.grey.withOpacity(0.5),
                                      child: Center(
                                          child: Text(
                                              "+${listAllImage!.length - 4}")),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      );
                    }),
              ),
        Divider(
          height: 1,
        ),
        ...List.generate(
          listReview!.length > 2 ? 2 : listReview!.length,
          (indexCustomer) => listReview![indexCustomer].status == 1
              ? Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          width: 20,
                          height: 20,
                          fit: BoxFit.cover,
                          imageUrl:
                              "${listReview![indexCustomer].customer!.avatarImage}",
                          errorWidget: (context, url, error) => ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[400],
                              ),
                              child: Icon(
                                Icons.person,
                                size: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "${listReview![indexCustomer].customer!.name ?? "(ẩn danh)"}"),
                            SizedBox(
                              height: 5,
                            ),
                            RatingBarIndicator(
                              rating:
                                  listReview![indexCustomer].stars!.toDouble(),
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: 15.0,
                              direction: Axis.horizontal,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            listReview![indexCustomer].content == null
                                ? Container()
                                : ReadMoreText(
                                    '${listReview![indexCustomer].content}.',
                                    trimLines: 1,
                                    style: TextStyle(color: Colors.grey[800]),
                                    colorClickableText: Colors.grey[500],
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText: '...xem thêm',
                                    trimExpandedText: ' thu gọn',
                                  ),
                            listImageReviewOfCustomer!.isEmpty
                                ? Container()
                                : Container(
                                    height: (Get.width / 3 - 35) + 20,
                                    width: Get.width,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: listImageReviewOfCustomer![
                                                      indexCustomer]
                                                  .length <=
                                              3
                                          ? listImageReviewOfCustomer![
                                                  indexCustomer]
                                              .length
                                          : 3,
                                      itemBuilder: (context, index) {
                                        return Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                seeImage(
                                                  listImageUrl:
                                                      listImageReviewOfCustomer![
                                                          indexCustomer],
                                                  index: index,
                                                );
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(2),
                                                  child: CachedNetworkImage(
                                                    width: Get.width / 3 - 30,
                                                    height: Get.width / 3 - 30,
                                                    fit: BoxFit.cover,
                                                    imageUrl:
                                                        "${listImageReviewOfCustomer![indexCustomer][index]}",
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              2),
                                                      child: CachedNetworkImage(
                                                          fit: BoxFit.cover,
                                                          imageUrl:
                                                              logoSahaImage),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            listImageReviewOfCustomer![
                                                                indexCustomer]
                                                            .length >
                                                        3 &&
                                                    index == 2
                                                ? InkWell(
                                                    onTap: () {
                                                      seeImage(
                                                        listImageUrl:
                                                            listImageReviewOfCustomer![
                                                                indexCustomer],
                                                        index: index,
                                                      );
                                                    },
                                                    child: Container(
                                                      width: Get.width / 3 - 30,
                                                      height:
                                                          Get.width / 3 - 30,
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      child: Center(
                                                        child: Text(
                                                            "+${listImageReviewOfCustomer![indexCustomer].length - 3}"),
                                                      ),
                                                    ),
                                                  )
                                                : Container(),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "${SahaDateUtils().getDDMMYY(listReview![indexCustomer].createdAt!)} ${SahaDateUtils().getHHMM(listReview![indexCustomer].createdAt!)}",
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 12),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
        ),
      ],
    );
  }

  void seeImage({
    List<dynamic>? listImageUrl,
    int? index,
  }) {
    PageController _pageController = PageController(initialPage: index!);
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: Get.context!,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Container(
              child: PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                pageController: _pageController,
                builder: (BuildContext context, int index) {
                  return PhotoViewGalleryPageOptions(
                    minScale: 0.0,
                    imageProvider: NetworkImage(listImageUrl![index] ?? ""),
                    initialScale: PhotoViewComputedScale.contained * 1,
                    heroAttributes: PhotoViewHeroAttributes(
                        tag: listImageUrl[index] ?? "error$index"),
                  );
                },
                itemCount: listImageUrl!.length,
                loadingBuilder: (context, event) => Center(
                  child: Container(
                    width: 20.0,
                    height: 20.0,
                    child: CupertinoActivityIndicator(),
                  ),
                ),
              ),
            ),
            Positioned(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withOpacity(0.5),
                ),
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Get.back();
                  },
                  color: Colors.white,
                ),
              ),
              top: 60,
              right: 20,
            )
          ],
        );
      },
    );
  }
}
