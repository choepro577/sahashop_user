import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:sahashop_user/components/saha_user/button/saha_button.dart';
import 'package:sahashop_user/components/saha_user/empty/empty_widget.dart';
import 'package:sahashop_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:sahashop_user/components/saha_user/loading/loading_widget.dart';
import 'package:sahashop_user/model/category_post.dart';
import 'add_category/add_category_screen.dart';
import 'category_controller.dart';

class CategoryPostScreen extends StatelessWidget {
  CategoryPostController categoryController = new CategoryPostController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SahaAppBar(
         titleText: "Tất cả danh mục",
        ),
        body: Obx(
          () => categoryController.loading.value
              ? SahaLoadingFullScreen()
              : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    children: [
                      Expanded(
                        child: Obx(() {
                          var list = categoryController.listCategoryPost?.toList().reversed.toList();
                          if (list == null || list.length == 0) {
                            return SahaEmptyWidget(
                              tile: "Không có danh mục nào",
                            );
                          }
                          return ListView.separated(
                              separatorBuilder: (context, index) => Divider(),
                              itemCount: list.length,
                              itemBuilder: (context, index) {
                                return ItemCategoryPostWidget(
                                  category: list[index],
                                );
                              });
                        }),
                      ),
                      SahaButtonFullParent(
                        onPressed: () {
                          Get.to(AddCategoryPostScreen()).then((value) {
                            if (value == "added") {
                              categoryController.getAllCategoryPost();
                            }
                          });
                        },
                        text: "Thêm danh mục mới",
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

class ItemCategoryPostWidget extends StatelessWidget {
  final CategoryPost category;

  const ItemCategoryPostWidget({Key key, this.category}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: CachedNetworkImage(
          height: 60,
          width: 60,
          fit: BoxFit.cover,
          imageUrl: category.imageUrl ?? "",
          placeholder: (context, url) => new SahaLoadingWidget(size: 30,),
          errorWidget: (context, url, error) => new Icon(Icons.error),
        ),
        title: Text(category.title ?? ""),
      ),
    );
  }
}
