import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/star_rating/star_rating.dart';
import 'package:sahashop_user/components/saha_user/text/read_more_text.dart';
import 'package:sahashop_user/const/const_image_logo.dart';

class ReviewProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(top: 15, bottom: 10, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ĐÁNH GIÁ SẢN PHẨM",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 9,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset("assets/icons/star_around.svg"),
                      SizedBox(
                        width: 4,
                      ),
                      SvgPicture.asset("assets/icons/star_around.svg"),
                      SizedBox(
                        width: 4,
                      ),
                      SvgPicture.asset("assets/icons/star_around.svg"),
                      SizedBox(
                        width: 4,
                      ),
                      SvgPicture.asset("assets/icons/star_around.svg"),
                      SizedBox(
                        width: 4,
                      ),
                      SvgPicture.asset("assets/icons/star_around.svg"),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "5/5",
                        style: TextStyle(color: Colors.red),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "(69 Đánh giá)",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    "Xem tất cả",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                      height: 10,
                      width: 10,
                      child: SvgPicture.asset(
                        "assets/icons/right_arrow.svg",
                        color: Theme.of(context).primaryColor,
                      ))
                ],
              )
            ],
          ),
        ),
        Divider(
          height: 1,
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text("Hình ảnh Người Mua"),
        ),
        Container(
          height: (Get.width / 4 - 10) + 20,
          width: Get.width,
          padding: const EdgeInsets.all(5.0),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: CachedNetworkImage(
                      width: Get.width / 4 - 12,
                      height: Get.width / 4 - 12,
                      fit: BoxFit.cover,
                      imageUrl: "",
                      errorWidget: (context, url, error) => ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: CachedNetworkImage(
                            fit: BoxFit.cover, imageUrl: logoSahaImage),
                      ),
                    ),
                  ),
                );
              }),
        ),
        Divider(
          height: 1,
        ),
        Padding(
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
                  imageUrl: "",
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
                    Text("HieuDepTrai"),
                    Container(
                      width: 80,
                      child: StarRating(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        starInput: 5,
                        sizeStar: 10,
                        spaceStar: 5,
                        onTap: (v) {},
                      ),
                    ),
                    ReadMoreText(
                      'Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.',
                      trimLines: 2,
                      colorClickableText: Colors.grey[500],
                      trimMode: TrimMode.Line,
                      trimCollapsedText: '...xem thêm',
                      trimExpandedText: ' thu gọn',
                    ),
                    Container(
                      height: (Get.width / 3 - 35) + 20,
                      width: Get.width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(2),
                              child: CachedNetworkImage(
                                width: Get.width / 3 - 30,
                                height: Get.width / 3 - 30,
                                fit: BoxFit.cover,
                                imageUrl: "",
                                errorWidget: (context, url, error) => ClipRRect(
                                  borderRadius: BorderRadius.circular(2),
                                  child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: logoSahaImage),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
