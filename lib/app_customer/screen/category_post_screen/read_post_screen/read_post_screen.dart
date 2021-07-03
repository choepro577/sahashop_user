import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_user/app_user/model/post.dart';
import 'package:sahashop_user/app_user/utils/date_utils.dart';

// ignore: must_be_immutable
class ReadPostScreen extends StatelessWidget {
  final Post? post;

  ReadPostScreen({this.post});
  Html? html;

  @override
  Widget build(BuildContext context) {
    html = Html(
      data: post!.content ?? " ",
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("${post!.title ?? "Tin tức"}"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              height: Get.height * 0.24,
              width: Get.width,
              fit: BoxFit.cover,
              imageUrl: post!.imageUrl ?? "",
              errorWidget: (context, url, error) => SahaEmptyImage(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Tin tức ngày: ${SahaDateUtils().getDDMMYY(DateTime.parse(post!.updatedAt!))}",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[500],
                ),
                maxLines: 2,
              ),
            ),
            html!,
          ],
        ),
      ),
    );
  }
}
