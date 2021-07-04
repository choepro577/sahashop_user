import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:readmore/readmore.dart';
import 'package:sahashop_user/app_customer/screen_default/review/see_review/star_page/star_page_controller.dart';
import 'package:sahashop_user/app_user/components/saha_user/empty_widget/saha_empty_review_widget.dart';
import 'package:sahashop_user/app_user/components/saha_user/loading/loading_shimmer.dart';
import 'package:sahashop_user/app_user/const/const_image_logo.dart';
import 'package:sahashop_user/app_user/utils/date_utils.dart';

// ignore: must_be_immutable
class StarPage extends StatefulWidget {
  final int? idProduct;
  final String? filterBy;
  final String? filterByValue;
  final bool? hasImage;

  StarPage(
      {Key? key,
      this.idProduct,
      this.filterBy,
      this.filterByValue,
      this.hasImage})
      : super(key: key);

  StarPageController starPageController = new StarPageController();

  @override
  _StarPageState createState() => _StarPageState();
}

class _StarPageState extends State<StarPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late StarPageController starPageController;

  RefreshController _refreshController = RefreshController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    starPageController = widget.starPageController;
    starPageController.idProductInput = widget.idProduct;
    starPageController.filterBy = widget.filterBy;
    starPageController.filterByValue = widget.filterByValue;
    starPageController.hasImage = widget.hasImage;
    starPageController.getReviewProduct(isLoadMoreCondition: false);
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    print(
      starPageController.listReview.length,
    );
    return SmartRefresher(
      enablePullDown: false,
      enablePullUp: true,
      header: MaterialClassicHeader(),
      footer: CustomFooter(
        builder: (
          BuildContext context,
          LoadStatus? mode,
        ) {
          Widget body = Container();
          if (mode == LoadStatus.idle) {
            body = Obx(() => starPageController.isLoadMore.value
                ? CupertinoActivityIndicator()
                : Container());
          } else if (mode == LoadStatus.loading) {
            body = Obx(() => starPageController.isLoadMore.value
                ? CupertinoActivityIndicator()
                : Container());
          }
          return Container(
            height: 0,
            child: Center(child: body),
          );
        },
      ),
      controller: _refreshController,
      onLoading: () async {
        await starPageController.getReviewProduct(isLoadMoreCondition: true);
        _refreshController.loadComplete();
      },
      child: Obx(
        () => starPageController.isLoading.value
            ? SahaSimmer(
                isLoading: true,
                child: Container(
                  width: Get.width,
                  height: Get.height,
                  color: Colors.black,
                ))
            : starPageController.listReview.isEmpty
                ? SahaEmptyReviewWidget(
                    width: 50,
                    height: 50,
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        ...List.generate(
                          starPageController.listReview.length,
                          (indexCustomer) =>
                              starPageController
                                          .listReview[indexCustomer].status ==
                                      1
                                  ? Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: CachedNetworkImage(
                                              width: 20,
                                              height: 20,
                                              fit: BoxFit.cover,
                                              imageUrl:
                                                  "${starPageController.listReview[indexCustomer].customer!.avatarImage}",
                                              errorWidget:
                                                  (context, url, error) =>
                                                      ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(100),
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    "${starPageController.listReview[indexCustomer].customer!.name ?? "(ẩn danh)"}"),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                RatingBarIndicator(
                                                  rating: starPageController
                                                      .listReview[indexCustomer]
                                                      .stars!
                                                      .toDouble(),
                                                  itemBuilder:
                                                      (context, index) => Icon(
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
                                                starPageController
                                                            .listReview[
                                                                indexCustomer]
                                                            .content ==
                                                        null
                                                    ? Container()
                                                    : ReadMoreText(
                                                        '${starPageController.listReview[indexCustomer].content}.',
                                                        trimLines: 1,
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey[800]),
                                                        colorClickableText:
                                                            Colors.grey[500],
                                                        trimMode: TrimMode.Line,
                                                        trimCollapsedText:
                                                            '...xem thêm',
                                                        trimExpandedText:
                                                            ' thu gọn',
                                                      ),
                                                starPageController
                                                        .listImageReviewOfCustomer[
                                                            indexCustomer]
                                                        .isEmpty
                                                    ? Container()
                                                    : Container(
                                                        height: (Get.width / 3 -
                                                                35) +
                                                            20,
                                                        width: Get.width,
                                                        child: ListView.builder(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          itemCount: starPageController
                                                                      .listImageReviewOfCustomer[
                                                                          indexCustomer]
                                                                      .length <=
                                                                  3
                                                              ? starPageController
                                                                  .listImageReviewOfCustomer[
                                                                      indexCustomer]
                                                                  .length
                                                              : 3,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return Stack(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              children: [
                                                                InkWell(
                                                                  onTap: () {
                                                                    seeImage(
                                                                      listImageUrl:
                                                                          starPageController
                                                                              .listImageReviewOfCustomer[indexCustomer],
                                                                      index:
                                                                          index,
                                                                    );
                                                                  },
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            5.0),
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              2),
                                                                      child:
                                                                          CachedNetworkImage(
                                                                        width: Get.width /
                                                                                3 -
                                                                            30,
                                                                        height:
                                                                            Get.width / 3 -
                                                                                30,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        imageUrl:
                                                                            "${starPageController.listImageReviewOfCustomer[indexCustomer][index]}",
                                                                        errorWidget: (context,
                                                                                url,
                                                                                error) =>
                                                                            ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(2),
                                                                          child: CachedNetworkImage(
                                                                              fit: BoxFit.cover,
                                                                              imageUrl: logoSahaImage),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                starPageController.listImageReviewOfCustomer[indexCustomer].length >
                                                                            3 &&
                                                                        index ==
                                                                            2
                                                                    ? InkWell(
                                                                        onTap:
                                                                            () {
                                                                          seeImage(
                                                                            listImageUrl:
                                                                                starPageController.listImageReviewOfCustomer[indexCustomer],
                                                                            index:
                                                                                index,
                                                                          );
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              Get.width / 3 - 30,
                                                                          height:
                                                                              Get.width / 3 - 30,
                                                                          color: Colors
                                                                              .grey
                                                                              .withOpacity(0.5),
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Text("+${starPageController.listImageReviewOfCustomer[indexCustomer].length - 3}"),
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
                                                  "${SahaDateUtils().getDDMMYY(starPageController.listReview[indexCustomer].createdAt!)} ${SahaDateUtils().getHHMM(starPageController.listReview[indexCustomer].createdAt!)}",
                                                  style: TextStyle(
                                                      color: Colors.grey[500],
                                                      fontSize: 12),
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
                    ),
                  ),
      ),
    );
  }

  void seeImage({
    List<dynamic>? listImageUrl,
    int? index,
  }) {
    PageController _pageController = PageController(initialPage: index!);
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
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
