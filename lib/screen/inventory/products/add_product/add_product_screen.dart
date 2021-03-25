import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/loading/loading.dart';
import 'package:sahashop_user/components/saha_user/sahashopTextField.dart';
import 'package:sahashop_user/screen/inventory/products/add_product/add_product_controller.dart';

import 'widget/select_images.dart';

class AddProductScreen extends StatelessWidget {
  final TextEditingController textEditingControllerName =
      new TextEditingController();
  final AddProductController addProductController = new AddProductController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DefaultTabController(
          length: 3,
          child: Scaffold(
              appBar: AppBar(
                title: Text("Thêm sản phẩm"),
                actions: [
                  InkWell(
                    onTap: () {
                      addProductController.createProduct();
                    },
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Thêm"),
                      ),
                    ),
                  )
                ],
                bottom: TabBar(
                  tabs: [
                    Tab(icon: Text("Thông tin chính")),
                    Tab(icon: Text("Thuộc tính")),
                    Tab(icon: Text("Nâng cao")),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  tab1(),
                  Icon(Icons.directions_transit),
                  Icon(Icons.directions_bike),
                ],
              )),
        ),
        Obx((){
        return (addProductController.isLoadingAdd.value) ? SahaLoadingFullScreen() : Container();
        })
      ],
    );
  }

  Widget tab1() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SahaTextField(
            onChanged: (value) {
              addProductController.productRequest.name = value;
            },
            validator: (value) {
              if (value.length == 0) {
                return 'Không được để trống';
              }
              return null;
            },
            labelText: "Tên sản phẩm",
            hintText: "Mời nhập tên sản phẩm",
          ),
          SelectProductImages(),
          SahaTextField(
            onChanged: (value) {
              addProductController.productRequest.description = value;
            },
            validator: (value) {
              if (value.length == 0) {
                return 'Không được để trống';
              }
              return null;
            },
            labelText: "Mô tả",
            hintText: "Mời nhập mô tả sản phẩm",
          ),
          SahaTextField(
            onChanged: (value) {
              addProductController.productRequest.price = int.tryParse(value);
            },
            validator: (value) {
              if (value.length == 0) {
                return 'Không được để trống';
              }
              return null;
            },
            textInputType: TextInputType.number,
            labelText: "Giá",
            hintText: "Mời nhập mô tả sản phẩm",
          ),
        ],
      ),
    );
  }
}
