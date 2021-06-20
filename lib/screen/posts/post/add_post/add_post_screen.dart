import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:sahashop_user/components/saha_user/button/saha_button.dart';
import 'package:sahashop_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:sahashop_user/components/saha_user/loading/loading_widget.dart';
import 'package:sahashop_user/components/saha_user/text_field/saha_text_filed_content.dart';
import 'package:sahashop_user/components/saha_user/text_field/sahashopTextField.dart';
import 'package:sahashop_user/model/category_post.dart';
//import 'package:smart_select/smart_select.dart';
import 'add_post_controller.dart';
import 'widget/select_image.dart';

class AddPostScreen extends StatelessWidget {
  final TextEditingController textEditingControllerTitle =
      new TextEditingController();
  final TextEditingController textEditingControllerDescription =
      new TextEditingController();
  final AddPostController addPostController = new AddPostController();
  final _formKey = GlobalKey<FormState>();

  File? imageSelected;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SahaAppBar(
        titleText: "Thêm bài viết",
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
                          addPostController.title = value;
                        },
                        validator: (value) {
                          if (value!.length == 0) {
                            return 'Không được để trống';
                          }
                          return null;
                        },
                        labelText: "Tên bài viết",
                        hintText: "Mời nhập tên bài viết",
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Row(
                          children: [
                            SelectPostImage(
                              onChange: (image) {
                                addPostController.image = image;
                                imageSelected = image;
                              },
                              fileSelected: imageSelected,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Ảnh đại diện cho bài viết"),
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
                      // Obx(
                      //   () => addPostController.isLoadingCategory.value
                      //       ? SahaLoadingWidget(
                      //           size: 15,
                      //         )
                      //       : SmartSelect<CategoryPost>.single(
                      //           title: "Chọn danh mục",
                      //           placeholder: "Mời chọn",
                      //           value: addPostController.postSelected.value,
                      //           choiceItems: addPostController.listCategory
                      //               .toList()
                      //               .map((e) =>
                      //                   S2Choice(value: e, title: e.title))
                      //               .toList(),
                      //           onChange: (va) {
                      //             addPostController.categoryId = va.value.id;
                      //           }),
                      // ),
                      SahaTextField(
                        onChanged: (value) {
                          addPostController.title = value;
                        },
                        labelText: "Mô tả",
                        hintText: "Mời nhập mô tả cho danh mục",
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Obx(() {
                          print(addPostController.content.value);
                          return Container(
                            child: SahaTextFiledContent(
                              onChangeContent: (html) {
                                addPostController.content.value = html;
                              },
                              contentSaved: addPostController.content.value,
                            ),
                          );
                        }),
                      )
                    ],
                  ),
                )),
                Row(
                  children: [
                    Expanded(
                      child: SahaButtonFullParent(
                        text: "Lưu tạm",
                        color: Colors.white,
                        textColor: Colors.black,
                        colorBorder: Colors.grey,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            addPostController.published = false;
                            addPostController.createPost();
                          }
                        },
                      ),
                    ),
                    Expanded(
                      child: SahaButtonFullParent(
                        text: "Hiển thị",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            addPostController.published = true;
                            addPostController.createPost();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Obx(() {
            return addPostController.isLoadingAdd.value
                ? SahaLoadingFullScreen()
                : Container();
          })
        ],
      ),
    );
  }
}
