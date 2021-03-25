import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'add_product/add_product_screen.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tất cả mặt hàng"),
      ),
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return Container();
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(()=>AddProductScreen());
        },
        child: Text("+"),
      ),
    );
  }
}
