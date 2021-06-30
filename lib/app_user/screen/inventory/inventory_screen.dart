import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_user/components/saha_user/app_bar/saha_appbar.dart';

import 'attribute/attributes_screen.dart';
import 'categories/category_screen.dart';
import 'products/product_screen.dart';

class InventoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SahaAppBar(
     titleText: "Quản lý mặt hàng",
      ),
      body: Column(
        children: [
          itemList(
              title: "Sản phẩm",
              onPress: () {
                Get.to(() => ProductScreen());
              }),
          itemList(
              title: "Danh mục",
              onPress: () {
                Get.to(() => CategoryScreen());
              }),
          itemList(
              title: "Các thuộc tính",
              onPress: () {
                Get.to(() => AttributeScreen());
              }),
        ],
      ),
    );
  }

  Widget itemList({
    Function? onPress,
    String? title,
  }) {
    return ListTile(
      title: Text("$title"),
      onTap: () {
        onPress!();
      },
    );
  }
}
