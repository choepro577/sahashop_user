import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/const/const_image_logo.dart';

class ReviewScreen extends StatelessWidget {
  List<String> listChooseReview = [
    "Chất lượng sản phẩm tuyệt vời",
    "Đóng gói sản phẩm rất đẹp"
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Đánh giá sản phẩm"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
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
                            imageUrl: "",
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
                        Text("Dep xam vmmm 1")
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/star_around.svg",
                          height: 30,
                          width: 30,
                        ),
                        SvgPicture.asset(
                          "assets/icons/star_around.svg",
                          height: 30,
                          width: 30,
                        ),
                        SvgPicture.asset(
                          "assets/icons/star_around.svg",
                          height: 30,
                          width: 30,
                        ),
                        SvgPicture.asset(
                          "assets/icons/star_around.svg",
                          height: 30,
                          width: 30,
                        ),
                        SvgPicture.asset(
                          "assets/icons/star_around.svg",
                          height: 30,
                          width: 30,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 70,
                    width: Get.width - 20,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.all(Radius.circular(2))),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.camera_alt,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Thêm hình ảnh",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 100,
                    width: Get.width - 20,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      border: Border.all(color: (Colors.grey[400])!),
                      borderRadius: BorderRadius.all(
                        Radius.circular(2),
                      ),
                    ),
                    child: TextFormField(
                      // controller: chatCustomerController
                      //     .messageEditingController.value,
                      onChanged: (v) {},
                      cursorColor: Colors.grey,
                      minLines: 1,
                      maxLines: 5,
                      //keyboardType: TextInputType.multiline,

                      decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        hintText:
                            "Hãy chia sẻ những điều bạn thích về sản phẩm này nhé.",
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                        return Container();
                      })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
