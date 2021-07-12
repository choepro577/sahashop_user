import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_user/app_customer/screen_default/category_post_screen/read_post_screen/input_model_post.dart';
import 'package:sahashop_user/app_customer/screen_default/category_post_screen/read_post_screen/read_post_screen.dart';
import 'package:sahashop_user/app_user/components/saha_user/loading/loading_container.dart';
import 'package:sahashop_user/app_user/model/post.dart';
import 'package:sahashop_user/app_user/utils/date_utils.dart';

class PostItemWidget extends StatelessWidget {
  const PostItemWidget({
    Key? key,
    required this.post,
    this.isLoading = false,
    this.width,
  }) : super(key: key);

  final Post post;
  final bool isLoading;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: width,
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(8),
          child: InkWell(
            onTap: () {
              // DataAppCustomerController dataAppCustomerController = Get.find();
              // dataAppCustomerController.toPostAllScreen();
              Get.to(() => ReadPostScreen(
                inputModelPost: InputModelPost(
                  post:post
                ),
                  ));
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                  child: isLoading
                      ? Container(
                          height: 70,
                          width: 70,
                          color: Colors.black,
                          child: Row(
                            children: [
                              Container(
                                height: 70,
                              )
                            ],
                          ),
                        )
                      : CachedNetworkImage(
                          height: 70,
                          width: 100,
                          fit: BoxFit.cover,
                          imageUrl: post.imageUrl == null ? "" : post.imageUrl!,
                          placeholder: (context,url) => SahaLoadingContainer(),
                    errorWidget: (context, url, error) => SahaEmptyImage(),
                        ), //post.images[0].imageUrl,
                ),
                SizedBox(width: 5),
                Expanded(
                  child: isLoading
                      ? Container(
                          width: 40,
                          height: 10,
                        )
                      : Padding(
                          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                          child: Container(
                            height: 70,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    post.title!,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold
                                    ),
                                    maxLines: 2,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(post.category != null && post.category!.length > 0
                                      ? post.category![0].title! : "",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.grey,
                                      ),
                                      maxLines: 2,
                                    ),
                                    Spacer(),
                                    Text(
                                      SahaDateUtils()
                                          .getDDMMYY(DateTime.parse(post.updatedAt!)),
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.grey,
                                      ),
                                      maxLines: 2,
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          ),
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
