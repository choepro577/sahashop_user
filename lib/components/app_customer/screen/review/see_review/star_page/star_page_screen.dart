import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:sahashop_user/components/app_customer/screen/review/see_review/star_page/star_page_controller.dart';
import 'package:sahashop_user/const/const_image_logo.dart';
import 'package:sahashop_user/utils/date_utils.dart';

// ignore: must_be_immutable
class StarPage extends StatefulWidget {
  final int? idProduct;
  final String? filterBy;
  final String? filterByValue;
  final bool? hasImage;

  StarPage({this.idProduct, this.filterBy, this.filterByValue, this.hasImage});

  StarPageController starPageController = new StarPageController();

  @override
  _StarPageState createState() => _StarPageState();
}

class _StarPageState extends State<StarPage> {
  late StarPageController starPageController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    starPageController = widget.starPageController;
    starPageController.idProductInput = widget.idProduct;
    starPageController.filterBy = widget.filterBy;
    starPageController.filterByValue = widget.filterByValue;
    starPageController.hasImage = widget.hasImage;
    starPageController.getReviewProduct();
  }

  @override
  Widget build(BuildContext context) {
    print(
      starPageController.listReview.length,
    );
    return Obx(
      () => SingleChildScrollView(
        child: Column(
          children: [
            ...List.generate(
              starPageController.listReview.length,
              (index) => starPageController.listReview[index].status == 1
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
                                  "${starPageController.listReview[index].customer!.avatarImage}",
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
                                    "${starPageController.listReview[index].customer!.name ?? "(ẩn danh)"}"),
                                SizedBox(
                                  height: 5,
                                ),
                                RatingBarIndicator(
                                  rating: starPageController
                                      .listReview[index].stars!
                                      .toDouble(),
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
                                starPageController.listReview[index].content ==
                                        null
                                    ? Container()
                                    : ReadMoreText(
                                        '${starPageController.listReview[index].content}.',
                                        trimLines: 1,
                                        style:
                                            TextStyle(color: Colors.grey[800]),
                                        colorClickableText: Colors.grey[500],
                                        trimMode: TrimMode.Line,
                                        trimCollapsedText: '...xem thêm',
                                        trimExpandedText: ' thu gọn',
                                      ),
                                starPageController
                                        .listImageReviewOfCustomer.isEmpty
                                    ? Container()
                                    : Container(
                                        height: (Get.width / 3 - 35) + 20,
                                        width: Get.width,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: 3,
                                          itemBuilder: (context, index) {
                                            return Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2),
                                                    child: CachedNetworkImage(
                                                      width: Get.width / 3 - 30,
                                                      height:
                                                          Get.width / 3 - 30,
                                                      fit: BoxFit.cover,
                                                      imageUrl:
                                                          "${starPageController!.listImageReviewOfCustomer[index]}",
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(2),
                                                        child: CachedNetworkImage(
                                                            fit: BoxFit.cover,
                                                            imageUrl:
                                                                logoSahaImage),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                starPageController
                                                            .listImageReviewOfCustomer
                                                            .length >
                                                        3
                                                    ? Container(
                                                        width:
                                                            Get.width / 3 - 30,
                                                        height:
                                                            Get.width / 3 - 30,
                                                        color: Colors.grey
                                                            .withOpacity(0.5),
                                                        child: Center(
                                                          child: Text(
                                                              "+${starPageController.listImageReviewOfCustomer.length - 3}"),
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
                                  "${SahaDateUtils().getDDMMYY(starPageController.listReview[index].createdAt!)} ${SahaDateUtils().getHHMM(starPageController.listReview[index].createdAt!)}",
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
        ),
      ),
    );
  }
}
