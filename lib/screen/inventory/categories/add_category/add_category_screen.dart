import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/button/saha_button.dart';
import 'package:sahashop_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:sahashop_user/components/saha_user/sahashopTextField.dart';
import 'package:sahashop_user/screen/inventory/categories/add_category/widget/select_image.dart';

import 'add_category_controller.dart';

class AddCategoryScreen extends StatelessWidget {
  final TextEditingController textEditingControllerName =
      new TextEditingController();
  final AddCategoryController addCategoryController =
      new AddCategoryController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thêm danh mục"),
      ),
      body: Obx(
        () => Stack(
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
                          onChanged: (value) {
                            addCategoryController.name = value;
                          },
                          validator: (value) {
                            if (value.length == 0) {
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
                              SelectCategoryImage(onChange: (image) {
                                addCategoryController.image = image;
                              }),
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
                      if (_formKey.currentState.validate()) {
                        addCategoryController.createCategory();
                      }
                    },
                  ),
                ],
              ),
            ),
            addCategoryController.isLoadingAdd.value
                ? SahaLoadingFullScreen()
                : Container()
          ],
        ),
      ),
    );
  }
}
