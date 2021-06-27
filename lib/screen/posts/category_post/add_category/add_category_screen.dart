import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:sahashop_user/components/saha_user/button/saha_button.dart';
import 'package:sahashop_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:sahashop_user/components/saha_user/text_field/sahashopTextField.dart';
import 'package:sahashop_user/model/category_post.dart';
import 'package:sahashop_user/screen/inventory/categories/add_category/widget/select_image.dart';
import 'add_category_controller.dart';
import 'widget/select_image.dart';

class AddCategoryPostScreen extends StatefulWidget {
  final CategoryPost? category;

  const AddCategoryPostScreen({Key? key, this.category}) : super(key: key);

  @override
  _AddCategoryPostScreenState createState() => _AddCategoryPostScreenState();
}

class _AddCategoryPostScreenState extends State<AddCategoryPostScreen> {
  final AddCategoryPostController addCategoryPostController =
      new AddCategoryPostController();

  final _formKey = GlobalKey<FormState>();

  File? imageSelected;

  @override
  void initState() {
    super.initState();
    addCategoryPostController.categoryEd = widget.category;
    if (widget.category != null) {
      addCategoryPostController.textEditingControllerDescription.text =
          widget.category!.description ?? "";
      addCategoryPostController.textEditingControllerTitle.text =
          widget.category!.title ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SahaAppBar(
        titleText: widget.category != null ? "Sửa" : "Thêm danh mục bài viết",
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
                        controller: addCategoryPostController
                            .textEditingControllerTitle,
                        onChanged: (value) {
                          addCategoryPostController.title = value;
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
                              linkImage: widget.category!.imageUrl,
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
                        controller: addCategoryPostController
                            .textEditingControllerDescription,
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
                  text: widget.category != null ? "Sửa" : "Thêm",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      addCategoryPostController.createCategoryPost();
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
            return addCategoryPostController.isLoadingAdd.value
                ? SahaLoadingFullScreen()
                : Container();
          })
        ],
      ),
    );
  }
}
