import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:sahashop_user/screen/posts/post/posts_screen.dart';
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
              title: "Tin tức - Bài viết",
              onPress: () {
                Get.to(() => PostScreen());
              }),
          itemList(
              title: "Danh mục bài viết",
              onPress: () {
                Get.to(() => CategoryPostScreen());
              }),
        ],
      ),
    );
  }

  Widget itemList({
    Function onPress,
    String title,
  }) {
    return ListTile(
      title: Text("$title"),
      onTap: () {
        onPress();
      },
    );
  }
}
