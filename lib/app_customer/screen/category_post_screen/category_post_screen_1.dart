import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import '../../components/product_item/post_item_widget.dart';
import '../../screen/data_app_controller.dart';
import '../../screen/search_screen/search_screen.dart';
import 'package:sahashop_user/app_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:sahashop_user/app_user/components/saha_user/loading/loading_shimmer.dart';
import 'package:sahashop_user/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:sahashop_user/app_user/controller/config_controller.dart';
import 'package:sahashop_user/app_user/model/category_post.dart';

import 'controller/category_post_controller.dart';

class CategoryPostStyle1 extends StatelessWidget {
  final ConfigController configController = Get.find();
  final DataAppCustomerController dataAppCustomerController = Get.find();
  final CategoryPostController categoryController = CategoryPostController()
    ..getAllCategoryPost();

  CategoryPostStyle1({Key? key}) : super(key: key);

  @override
  void dispose() {}

  @override
  Widget build(BuildContext context) {
    ////  ////  ////  ////  ////  ////
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(title: Text("Tin tức")),
      body: Obx(
        () => Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              child: categoryController.isLoadingCategoryPost.value
                  ? SahaLoadingWidget()
                  : Container(
                      width: Get.width,
                      child: ListView.builder(
                          itemCount: categoryController.categories.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                buildItem(
                                    category:
                                        categoryController.categories[index]),
                              ],
                            );
                          }),
                    ),
            ),
            Expanded(child: buildList()),
          ],
        ),
      ),
    );
  }

  Widget buildList() {
    return Obx(() {
      var isLoading = categoryController.isLoadingPost.value;
      List list = isLoading ? [] : categoryController.posts.toList();
      return Padding(
        padding: const EdgeInsets.all(2.5),
        child: SahaSimmer(
          isLoading: isLoading,
          child: StaggeredGridView.countBuilder(
            crossAxisCount: 1,
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) => PostItemWidget(
              post: list[index],
              isLoading: isLoading,
            ),
            staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
          ),
        ),
      );
    });
  }

  Widget buildItem({CategoryPost? category}) {
    return Obx(() => Container(
          height: 40,
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 3, top: 3),
          decoration: BoxDecoration(
              border: Border.all(
                  color: categoryController.categoryCurrent.value.id ==
                          category!.id
                      ? Theme.of(Get.context!).primaryColor
                      : Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.white),
          child: InkWell(
            onTap: () {
              categoryController.setCategoryPostCurrent(category);
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 5,
                ),
                category.imageUrl == null || category.imageUrl == ""
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: SizedBox(
                          width: 30,
                          height: 30,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(3)),
                            child: CachedNetworkImage(
                              imageUrl: category.imageUrl ?? "",
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Container(),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                Text(
                  "${category.title ?? ""}",
                  maxLines: 3,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: categoryController.categoryCurrent.value.id ==
                              category.id
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color:
                          categoryController.categoryCurrent.value == category
                              ? Theme.of(Get.context!).primaryColor
                              : Colors.black54),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ));
  }
}
