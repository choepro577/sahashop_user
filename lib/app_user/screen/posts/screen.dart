import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sahashop_user/app_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:sahashop_user/app_user/const/constant.dart';
import 'package:sahashop_user/app_user/screen/posts/post/posts_screen.dart';
import 'category_post/category_screen.dart';

class PostNaviScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SahaAppBar(
        titleText: "Quản lý tin tức bài viết",
      ),
      body: Column(
        children: [
          itemList(
              icon: Icon(Ionicons.reader_outline,
                color: SahaPrimaryColor,
              ),
              title: "Tin tức - bài viết",
              onPress: () {
                Get.to(() => PostScreen());
              }),
          itemList(
              icon: Icon(Ionicons.library_outline,
                color: SahaPrimaryColor,
              ),
              title: "Danh mục bài viết",
              onPress: () {
                Get.to(() => CategoryPostScreen(
                      isSelect: false,
                    ));
              }),
        ],
      ),
    );
  }

  Widget itemList({
    Function? onPress,
    String? title,
    Icon? icon
  }) {
    return ListTile(
      leading: icon,
      title: Text("$title"),
      onTap: () {
        onPress!();
      },
    );
  }
}
