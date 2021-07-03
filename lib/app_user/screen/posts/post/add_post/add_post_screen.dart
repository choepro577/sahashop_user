import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:sahashop_user/app_user/components/saha_user/button/saha_button.dart';
import 'package:sahashop_user/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:sahashop_user/app_user/components/saha_user/text_field/saha_text_filed_content.dart';
import 'package:sahashop_user/app_user/components/saha_user/text_field/sahashopTextField.dart';
import 'package:sahashop_user/app_user/model/category_post.dart';
import 'package:sahashop_user/app_user/model/post.dart';
import 'package:sahashop_user/app_user/screen/posts/category_post/category_screen.dart';
import 'add_post_controller.dart';
import 'widget/select_image.dart';

// ignore: must_be_immutable
class AddPostScreen extends StatefulWidget {
  final Post? post;

  AddPostScreen({Key? key, this.post}) : super(key: key);

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController textEditingControllerTitle =
      new TextEditingController();

  final TextEditingController textEditingControllerDescription =
      new TextEditingController();

  final AddPostController addPostController = new AddPostController();

  final _formKey = GlobalKey<FormState>();

  File? imageSelected;

  @override
  void initState() {
    if (widget.post != null) {
      addPostController.imageUrl = widget.post!.imageUrl ?? "";
      addPostController.title = widget.post!.title ?? "Tin tức";
      textEditingControllerTitle.text = widget.post!.title ?? "";
      textEditingControllerDescription.text = widget.post!.summary ?? "";
      addPostController.content.value = widget.post!.content ?? "";
      addPostController.categoryPostSelected.value =
          widget.post!.category!.isEmpty
              ? CategoryPost()
              : widget.post!.category![0];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SahaAppBar(
        titleText: widget.post != null ? "Sửa" : "Thêm danh mục bài viết",
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
                        controller: textEditingControllerTitle,
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
                              linkImage: widget.post == null
                                  ? ""
                                  : widget.post!.imageUrl == null
                                      ? ""
                                      : widget.post!.imageUrl!,
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
                      SahaTextField(
                        controller: textEditingControllerDescription,
                        onChanged: (value) {
                          addPostController.summary = value;
                        },
                        labelText: "Mô tả",
                        hintText: "Mời nhập mô tả cho danh mục",
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(CategoryPostScreen(
                            isSelect: true,
                            categoryPostSelected:
                                addPostController.categoryPostSelected.value,
                          ))!
                              .then((value) => {
                                    addPostController
                                        .setNewCategoryPostSelected(value)
                                  });
                        },
                        child: Column(
                          children: [
                            Container(
                                padding: EdgeInsets.all(16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(Icons.wysiwyg_outlined),
                                    Text(
                                      " Danh mục bài viết",
                                      style: TextStyle(
                                          color: Colors.black87, fontSize: 16),
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 4),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 15,
                                        color: Colors.grey,
                                      ),
                                    )
                                  ],
                                )),
                            buildListCategory()
                          ],
                        ),
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
                            if (widget.post != null) {
                              addPostController.published = false;
                              addPostController.updatePost(widget.post!.id);
                            } else {
                              addPostController.published = false;
                              addPostController.createPost();
                            }
                          }
                        },
                      ),
                    ),
                    Expanded(
                      child: SahaButtonFullParent(
                        text: widget.post != null ? "Cập nhật" : "Hiển thị",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (widget.post != null) {
                              addPostController.published = true;
                              addPostController.updatePost(widget.post!.id);
                            } else {
                              addPostController.published = true;
                              addPostController.createPost();
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
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

  Widget buildListCategory() {
    return Obx(() => addPostController.categoryPostSelected.value.id == null
        ? Container()
        : Column(
            children: [
              Container(
                height: 1,
                color: Colors.grey[100],
              ),
              Container(
                height: 50,
                padding:
                    EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CachedNetworkImage(
                      fit: BoxFit.cover,
                      height: 50,
                      width: 50,
                      imageUrl: addPostController
                          .categoryPostSelected.value.imageUrl!,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                                  value: downloadProgress.progress),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(addPostController.categoryPostSelected.value.title!),
                    Spacer(),
                    IconButton(
                        icon: Icon(
                          Icons.clear,
                          size: 12,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          addPostController.categoryPostSelected.value.id =
                              null;
                          addPostController.categoryPostSelected.refresh();
                        })
                  ],
                ),
              ),
            ],
          ));
  }
}
