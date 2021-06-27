import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sahashop_user/components/app_customer/screen/review/see_review/see_review_controller.dart';
import 'package:sahashop_user/components/app_customer/screen/review/see_review/star_page/star_page_screen.dart';
import 'package:sahashop_user/components/saha_user/loading/loading_shimmer.dart';

// ignore: must_be_immutable
class SeeReviewScreen extends StatelessWidget {
  final int? idProduct;

  SeeReviewScreen({this.idProduct}) {
    seeReviewController = SeeReviewController(idProductInput: idProduct);
    _refreshController = RefreshController();
  }

  RefreshController? _refreshController;
  SeeReviewController? seeReviewController;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Đánh giá"),
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: seeReviewController!.isLoading.value
              ? SahaSimmer(
                  isLoading: true,
                  child: Container(
                    width: Get.width,
                    height: Get.height,
                    color: Colors.black,
                  ))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 5.0, right: 5.0, top: 10.0),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              seeReviewController!.changeIndexReview(0);
                            },
                            child: Container(
                              height: 35,
                              width: Get.width / 2 - 10,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(3),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Tất cả",
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  Obx(
                                    () => Text(
                                      "(${seeReviewController!.totalReview.value})",
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              seeReviewController!.changeIndexReview(1);
                            },
                            child: Container(
                              height: 35,
                              width: Get.width / 2 - 10,
                              decoration:
                                  BoxDecoration(color: Colors.grey[200]),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Có hình ảnh",
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  Obx(
                                    () => Text(
                                      "${seeReviewController!.totalHasImage.value}",
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: Get.width,
                      child: Row(
                        children: [
                          ...List.generate(5, (index) => chooseStar(index)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(
                      height: 1,
                    ),
                    Obx(
                      () => Container(
                        width: Get.width,
                        height: Get.height,
                        child: IndexedStack(
                          index: seeReviewController!.currentIndexReview.value,
                          children: [
                            new StarPage(
                              idProduct: idProduct,
                              filterBy: "",
                              filterByValue: "",
                              hasImage: null,
                            ),
                            new StarPage(
                              idProduct: idProduct,
                              filterBy: "",
                              filterByValue: "",
                              hasImage: true,
                            ),
                            new StarPage(
                              idProduct: idProduct,
                              filterBy: "stars",
                              filterByValue: "1",
                              hasImage: null,
                            ),
                            new StarPage(
                              idProduct: idProduct,
                              filterBy: "stars",
                              filterByValue: "2",
                              hasImage: null,
                            ),
                            new StarPage(
                              idProduct: idProduct,
                              filterBy: "stars",
                              filterByValue: "3",
                              hasImage: null,
                            ),
                            new StarPage(
                              idProduct: idProduct,
                              filterBy: "stars",
                              filterByValue: "4",
                              hasImage: null,
                            ),
                            new StarPage(
                              idProduct: idProduct,
                              filterBy: "stars",
                              filterByValue: "5",
                              hasImage: null,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }

  Widget chooseStar(int index) {
    return InkWell(
      onTap: () {
        seeReviewController!.changeIndexReview(index + 2);
      },
      child: Container(
        height: 35,
        width: Get.width / 5 - 10,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.all(Radius.circular(3))),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RatingBarIndicator(
                rating: (index + 1).toDouble(),
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: index + 1,
                itemSize: 13.0,
                direction: Axis.horizontal,
              ),
              Obx(
                () => Text(
                  "(${seeReviewController!.listStarOneToFive[index]})",
                  style: TextStyle(fontSize: 10),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
