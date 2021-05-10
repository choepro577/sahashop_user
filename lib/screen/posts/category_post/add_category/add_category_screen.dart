import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:sahashop_user/components/saha_user/button/saha_button.dart';
import 'package:sahashop_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:sahashop_user/components/saha_user/text_field/sahashopTextField.dart';
import 'add_category_controller.dart';
import 'widget/select_image.dart';

class AddCategoryPostScreen extends StatelessWidget {
  final TextEditingController textEditingControllerTitle =
      new TextEditingController();
  final TextEditingController textEditingControllerDescription =
  new TextEditingController();
  final AddCategoryPostController addCategoryPostController =
      new AddCategoryPostController();
  final _formKey = GlobalKey<FormState>();

  File imageSelected;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SahaAppBar(
       titleText: "Thêm danh mục bài viết",
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
                          onChanged: (value) {
                            addCategoryPostController.title = value;
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
                              SelectCategoryPostImage(
                                onChange: (image) {
                                  addCategoryPostController.image = image;
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

                        SahaTextField(
                          onChanged: (value) {
                            addCategoryPostController.title = value;
                          },
                          labelText: "Mô tả",
                          hintText: "Mời nhập mô tả cho danh mục",
                        ),
                      ],
                    ),
                  )),
                  SahaButtonFullParent(
                    text: "Thêm",
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        addCategoryPostController.createCategoryPost();
                      }
                    },
                  ),
                ],
              ),
            ),
            Obx((){
             return addCategoryPostController.isLoadingAdd.value
                  ? SahaLoadingFullScreen()
                  : Container();
            })
          ],
      ),
    );
  }
}
