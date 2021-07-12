import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_user/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:sahashop_user/app_user/utils/date_utils.dart';

import 'input_model_post.dart';
import 'read_post_controller.dart';

// ignore: must_be_immutable
class ReadPostScreen extends StatelessWidget {
  InputModelPost? inputModelPost;
  late PostController postController;

  ReadPostScreen({this.inputModelPost}) {
    postController = PostController(inputModelPost);
  }
  Html? html;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${postController.isLoadingPost.value == false && postController.postShow.value.title != null ? postController.postShow.value.title : "Tin tức"}"),
      ),
      body: Obx(
        () => Stack(
          children: [
            postController.isLoadingPost.value
                ? Container()
                :   SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    height: Get.height * 0.24,
                    width: Get.width,
                    fit: BoxFit.cover,
                    imageUrl: postController.postShow.value.imageUrl ?? "",
                    errorWidget: (context, url, error) => SahaEmptyImage(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Tin tức ngày: ${SahaDateUtils().getDDMMYY(DateTime.parse(postController.postShow.value.updatedAt!))}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[500],
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Html(
                    data: postController.postShow.value.content ?? " ",
                  ),
                ],
              ),
            ),

                    postController.isLoadingPost.value
                ? Center(
                    child: SahaLoadingWidget(),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
