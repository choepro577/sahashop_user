import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/app_bar/saha_appbar.dart';

import 'categories/category_screen.dart';
import 'products/product_screen.dart';

class InventoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SahaAppBar(
        title: Text("Quản lý mặt hàng"),
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
