import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_user/components/saha_user/loading/loading_container.dart';
import '../../components/product_item/post_item_widget.dart';
import '../../screen_default/data_app_controller.dart';
import '../../screen_default/search_screen/search_screen.dart';
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

            Container(
              height: 45,
              child: categoryController.isLoadingCategoryPost.value
                  ? SahaLoadingWidget()
                  : Container(
                      width: Get.width,
                      color: Colors.white,
                      child: ListView.builder(
                          itemCount: categoryController.categories.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [

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
          child: ListView.separated(
            itemBuilder: (BuildContext context, int index) => PostItemWidget(
              post: list[index],
              isLoading: isLoading,
            ),
            separatorBuilder: (BuildContext context, int index) => Padding(
              padding: const EdgeInsets.only(left: 5,right: 5),
              child: Divider(
                color: Colors.grey[100],
                height: 2,
              ),
            ),
            itemCount: list.length,
          ),
        ),
      );
    });
  }

  Widget buildItem({CategoryPost? category}) {
    return Obx(() => Container(

          padding: EdgeInsets.only(top: 10,bottom: 10,right: 15,left: 15),

          decoration: BoxDecoration(
              border: Border(

                  bottom: BorderSide(
                    color: categoryController.categoryCurrent.value.id ==
                        category!.id
                        ? Theme.of(Get.context!).primaryColor
                        : Colors.white,
                    width: 2,
                  )),


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
                          width: 40,
                          height: 40,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(2)),
                            child: CachedNetworkImage(
                              imageUrl: category.imageUrl ?? "",
                              placeholder: (context, url) =>
                                SahaLoadingContainer(),
                              errorWidget: (context, url, error) => Container(),
                              fit: BoxFit.fitWidth,
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
