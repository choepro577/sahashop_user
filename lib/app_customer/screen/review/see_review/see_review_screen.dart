import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_user/components/saha_user/loading/loading_shimmer.dart';

import 'see_review_controller.dart';
import 'star_page/star_page_screen.dart';

// ignore: must_be_immutable
class SeeReviewScreen extends StatefulWidget {
  final int? idProduct;

  SeeReviewScreen({this.idProduct});

  @override
  _SeeReviewScreenState createState() => _SeeReviewScreenState();
}

class _SeeReviewScreenState extends State<SeeReviewScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final PageStorageBucket bucket = PageStorageBucket();

  late SeeReviewController seeReviewController;

  List<Widget>? pages;

  @override
  void initState() {
    seeReviewController =
        new SeeReviewController(idProductInput: widget.idProduct);
    pages = <Widget>[
      StarPage(
        key: PageStorageKey<String>('pending_approval'),
        idProduct: widget.idProduct,
        filterBy: "",
        filterByValue: "",
        hasImage: null,
      ),
      StarPage(
        key: PageStorageKey<String>('cancel'),
        idProduct: widget.idProduct,
        filterBy: "",
        filterByValue: "",
        hasImage: true,
      ),
      StarPage(
        key: PageStorageKey<String>('star1'),
        idProduct: widget.idProduct,
        filterBy: "stars",
        filterByValue: "1",
        hasImage: null,
      ),
      StarPage(
        key: PageStorageKey<String>('star2'),
        idProduct: widget.idProduct,
        filterBy: "stars",
        filterByValue: "2",
        hasImage: null,
      ),
      StarPage(
        key: PageStorageKey<String>('star3'),
        idProduct: widget.idProduct,
        filterBy: "stars",
        filterByValue: "3",
        hasImage: null,
      ),
      StarPage(
        key: PageStorageKey<String>('star4'),
        idProduct: widget.idProduct,
        filterBy: "stars",
        filterByValue: "4",
        hasImage: null,
      ),
      StarPage(
        key: PageStorageKey<String>('star5'),
        idProduct: widget.idProduct,
        filterBy: "stars",
        filterByValue: "5",
        hasImage: null,
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Đánh giá"),
      ),
      body: Obx(
        () => seeReviewController.isLoading.value
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
                    padding:
                        const EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            seeReviewController.changeIndexReview(0);
                          },
                          child: Container(
                            height: 35,
                            width: Get.width / 2 - 10,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border: Border.all(
                                  color: seeReviewController
                                              .currentIndexReview.value ==
                                          0
                                      ? Theme.of(context).primaryColor
                                      : Colors.transparent),
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
                                    "(${seeReviewController.totalReview.value})",
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
                            seeReviewController.changeIndexReview(1);
                          },
                          child: Container(
                            height: 35,
                            width: Get.width / 2 - 10,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border: Border.all(
                                  color: seeReviewController
                                              .currentIndexReview.value ==
                                          1
                                      ? Theme.of(context).primaryColor
                                      : Colors.transparent),
                              borderRadius: BorderRadius.all(
                                Radius.circular(3),
                              ),
                            ),
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
                                    "(${seeReviewController.totalHasImage.value})",
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
                    () => Expanded(
                      child: PageStorage(
                        bucket: bucket,
                        child: pages![
                            seeReviewController.currentIndexReview.value],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget chooseStar(int index) {
    return InkWell(
      onTap: () {
        seeReviewController.changeIndexReview(index + 2);
      },
      child: Container(
        height: 35,
        width: Get.width / 5 - 10,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(
              color: seeReviewController.currentIndexReview.value == index + 2
                  ? Theme.of(context).primaryColor
                  : Colors.transparent),
          borderRadius: BorderRadius.all(
            Radius.circular(3),
          ),
        ),
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
                  "(${seeReviewController.listStarOneToFive[index]})",
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
