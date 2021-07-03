import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_user/app_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:sahashop_user/app_user/components/saha_user/button/saha_button.dart';
import 'package:sahashop_user/app_user/components/saha_user/dialog/dialog.dart';
import 'package:sahashop_user/app_user/components/saha_user/empty_widget/empty_widget.dart';
import 'package:sahashop_user/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:sahashop_user/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:sahashop_user/app_user/model/post.dart';

import 'add_post/add_post_screen.dart';
import 'posts_controller.dart';

class PostScreen extends StatelessWidget {
  PostController postController = new PostController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SahaAppBar(
          titleText: "Tất cả bài viết",
        ),
        body: Obx(
          () => postController.loading.value
              ? SahaLoadingFullScreen()
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: Obx(() {
                          var list = postController.listPost
                              .toList()
                              .reversed
                              .toList();
                          if (list == null || list.length == 0) {
                            return SahaEmptyWidget(
                              tile: "Không có danh mục nào",
                            );
                          }
                          return ListView.separated(
                              separatorBuilder: (context, index) => Divider(),
                              itemCount: list.length,
                              itemBuilder: (context, index) {
                                return ItemPostWidget(
                                  post: list[index],
                                  isFix: true,
                                  postController: postController,
                                );
                              });
                        }),
                      ),
                      SahaButtonFullParent(
                        onPressed: () {
                          Get.to(AddPostScreen())!.then((value) {
                            if (value == "added") {
                              postController.getAllPost();
                            }
                          });
                        },
                        text: "Thêm bài viết mới",
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
        ));
  }
}

class ItemPostWidget extends StatelessWidget {
  final Function? onTap;
  final bool? isFix;
  final PostController? postController;
  final Post? post;

  const ItemPostWidget(
      {Key? key, this.post, this.onTap, this.isFix, this.postController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
          onTap: () {
            if (isFix!) {
              Get.to(AddPostScreen(post: post))!.then((value) {
                if (value == "added") {
                  postController!.getAllPost();
                }
              });
            }
          },
          leading: CachedNetworkImage(
            height: 60,
            width: 60,
            fit: BoxFit.cover,
            imageUrl: post!.imageUrl ?? "",
            placeholder: (context, url) => new SahaLoadingWidget(
              size: 30,
            ),
            errorWidget: (context, url, error) => SahaEmptyImage(),
          ),
          title: Text(post!.title ?? ""),
          trailing: IconButton(
              icon: Icon(Icons.delete_rounded),
              onPressed: () {
                SahaDialogApp.showDialogYesNo(
                    mess: "Bạn muốn xóa danh mục này?",
                    onOK: () {
                      postController!.deletePost(post!.id!);
                      postController!.getAllPost();
                    });
              })),
    );
  }
}
