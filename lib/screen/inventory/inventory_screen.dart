import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'categories/category_screen.dart';
import 'products/product_screen.dart';

class InventoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
