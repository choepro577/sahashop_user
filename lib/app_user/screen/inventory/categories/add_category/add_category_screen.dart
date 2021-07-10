import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:sahashop_user/app_user/components/saha_user/button/saha_button.dart';
import 'package:sahashop_user/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:sahashop_user/app_user/components/saha_user/text_field/sahashopTextField.dart';
import 'package:sahashop_user/app_user/model/category.dart';
import 'package:sahashop_user/app_user/screen/inventory/categories/add_category/widget/select_image.dart';

import 'add_category_controller.dart';

class AddCategoryScreen extends StatelessWidget {

  final AddCategoryController addCategoryController =
      new AddCategoryController();
  final _formKey = GlobalKey<FormState>();

  final Category? category;

  File? imageSelected;

  AddCategoryScreen({Key? key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (category != null) {
      addCategoryController.textEditingControllerName.text = category!.name!;
    }

    return Scaffold(
      appBar: SahaAppBar(
        titleText: "Thêm danh mục",
      ),
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SahaTextField(
                        controller: addCategoryController.textEditingControllerName,
                        onChanged: (value) {
                          addCategoryController.name = value;
                        },
                        validator: (value) {
                          if (value!.length == 0) {
                            return 'Không được để trống';
                          }
                          return null;
                        },
                        labelText: "Tên danh mục",
                        hintText: "Mời nhập tên danh mục",
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Row(
                          children: [
                            SelectCategoryImage(
                              linkImage: category != null &&
                                      category!.imageUrl != null
                                  ? category!.imageUrl!
                                  : "",
                              onChange: (image) {
                                addCategoryController.image = image;
                                imageSelected = image;
                              },
                              fileSelected: imageSelected,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Ảnh danh mục"),
                                  Text(
                                    "Có thể không chọn",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontStyle: FontStyle.italic),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
                SahaButtonFullParent(
                  text: "Thêm",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      addCategoryController.createCategory(
                        categoryId: category != null ? category!.id : null,
                        imageUrl: category != null ? category!.imageUrl : null,
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
          Obx(() {
            return addCategoryController.isLoadingAdd.value
                ? SahaLoadingFullScreen()
                : Container();
          })
        ],
      ),
    );
  }
}
